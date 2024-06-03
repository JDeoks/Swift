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
    /// 셀  생성
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        
        let cell = calendar.dequeueReusableCell(withIdentifier: CalendarCell.description(), for: date, at: position) as! CalendarCell
        
        // 이미지 임시 설정
//        let randomInt = Int.random(in: 1...100)
        if  [1, 3, 5, 12, 17, 20, 24].contains(Int(date.dayStr)) {
            let url = URL(string: "https://picsum.photos/200?random=\(date.dayStr)")
            cell.backImageView.kf.setImage(with: url, options: [.transition(.fade(0.5))])
        }
        
        // 현재 달 날짜만 색 진하게 설정
        if position == .current {
            cell.backImageView.alpha = 1
            cell.dateLabel.alpha = 1
        } else {
            cell.backImageView.alpha = 0.3
            cell.dateLabel.alpha = 0.3
        }
        
        // 날짜 텍스트 설정
        cell.dateLabel.text = "\(date.dayStr)"
        
        // 오늘 날짜 초록색
        if Date.isSameDay(date, Date()) {
            cell.dateLabel.textColor = .systemGreen
        } else {
            cell.dateLabel.textColor = .black
        }
        
        // 선택한 날짜 밑줄
        if let selectedDate = calendar.selectedDate {
            if Date.isSameDay(date, selectedDate) {
                cell.selectIndicator.alpha = 1
            } else {
                cell.selectIndicator.alpha = 0
            }
        }

        return cell
    }

    /// 선택 시
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(type(of: self), #function)

        guard let cell = calendar.cell(for: date, at: monthPosition) as? CalendarCell else {
            return
        }
        cell.selectIndicator.alpha = 1
    }
    
    /// 선택 해제 시
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(type(of: self), #function)
        
        guard let cell = calendar.cell(for: date, at: monthPosition) as? CalendarCell else {
            return
        }
        cell.selectIndicator.alpha = 0
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        print(type(of: self), #function, bounds.height)
        
        calendarHeight.constant = bounds.height
        self.view.layoutIfNeeded()
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
