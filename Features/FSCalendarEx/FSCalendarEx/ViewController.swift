//
//  ViewController.swift
//  FSCalendarEx
//
//  Created by JDeoks on 6/2/24.
//

import Foundation
import UIKit
import FSCalendar
import RxSwift
import RxCocoa
import RxGesture
import SwiftDate
import Kingfisher

class ViewController: UIViewController {

    private var calanderMode: CalendarMode = .week
    
    @IBOutlet var monthButtonStackView: UIStackView!
    @IBOutlet var calendar: FSCalendar!
    @IBOutlet var calendarHeight: NSLayoutConstraint!
    @IBOutlet var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        action()
        initData()
        
        let now = Date()
        if let dateOnly = DateManager.getDay(from: now) {
            print(dateOnly)  // 출력: yyyy-MM-dd 00:00:00 형태의 날짜
        }
    }
    
    private func initUI() {
        // calander
        calendar.dataSource = self
        calendar.delegate = self
        // 스코프 설정
        calendar.scope = .week
        // 헤더 없애기
        calendar.calendarHeaderView.isHidden = true
        calendar.headerHeight = 8
        // 요일 높이 설정
        calendar.weekdayHeight = 20
        // CalendarCell 등록
        calendar.register(CalendarCell.self, forCellReuseIdentifier: CalendarCell.description())
        // 선택한 날짜, 오늘 날짜 원 색상 제거
        calendar.appearance.selectionColor = .clear
        calendar.appearance.todayColor = .clear
        // 요일 표시 언어 설정
        calendar.locale = Locale(identifier: "ko_KR")
        // 요일 색 설정
        calendar.appearance.weekdayTextColor = .black
        calendar.backgroundColor = .clear
        
        // tableView
        tableView.dataSource = self
        tableView.delegate = self
        // TodoTableViewCell 등록
        let todoTableViewCell = UINib(nibName: "TodoTableViewCell", bundle: nil)
        tableView.register(todoTableViewCell, forCellReuseIdentifier: "TodoTableViewCell")
    }
    
    private func initData() {
        calendar.select(Date())
    }
    
    private func action() {
        // 주단위 월단위 스위치 버튼
        monthButtonStackView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                print("monthButtonStackView.rx.tapGesture()")
                if self.calanderMode == .month {
                    self.calanderMode = .week
                    self.calendar.setScope(.week, animated: true)
                } else {
                    self.calanderMode = .month
                    self.calendar.setScope(.month, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
}

extension ViewController: FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        print(type(of: self), #function, bounds.height)
        
        calendarHeight.constant = bounds.height// * heightRatio
        self.view.layoutIfNeeded()
    }

    
    /// 셀  생성
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        
//        print(type(of: self), #function)
        let cell = calendar.dequeueReusableCell(withIdentifier: CalendarCell.description(), for: date, at: position) as! CalendarCell
//        print(type(of: self), #function, cell.frame)

        // TODO: - 이번 저번 달 글씨 색

        let randomInt = Int.random(in: 1...100)
        if randomInt < 30 {
            let url = URL(string: "https://picsum.photos/200/300?random=\(randomInt)")
            cell.backImageView.kf.setImage(with: url, options: [.transition(.fade(0.5))])
        }
        // 현재 달 날짜만 색 진하게 설정
        if position == .current {
            cell.backImageView.alpha = 1
            cell.dateLabel.alpha = 1
//            cell.selectIndicator.alpha = 1
        } else {
            cell.backImageView.alpha = 0.3
            cell.dateLabel.alpha = 0.3
//            cell.selectIndicator.alpha = 0
        }
        
        cell.dateLabel.text = "\(date.dayStr)"
        return cell
    }

    /// 선택 시
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(type(of: self), #function)

        let cell = calendar.cell(for: date, at: monthPosition) as! CalendarCell
        cell.selectIndicator.alpha = 1
    }
    
    /// 선택 해제 시
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(type(of: self), #function)

        let cell = calendar.cell(for: date, at: monthPosition) as! CalendarCell
        cell.selectIndicator.alpha = 0
    }
}



extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let todoCell = tableView.dequeueReusableCell(withIdentifier: "TodoTableViewCell") as? TodoTableViewCell else {
            return UITableViewCell()
        }
        todoCell.title.text = "\(indexPath)"
        return todoCell
    }
}
