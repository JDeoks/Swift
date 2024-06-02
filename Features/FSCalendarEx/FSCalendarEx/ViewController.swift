//
//  ViewController.swift
//  FSCalendarEx
//
//  Created by JDeoks on 6/2/24.
//


import UIKit
import FSCalendar
import RxSwift
import RxCocoa
import RxGesture
import SwiftDate
import Kingfisher

class ViewController: UIViewController {
    
    var currentMonth: Date!

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
        calendar.register(CalendarCell.self, forCellReuseIdentifier: CalendarCell.description())
        // 선택한 날짜, 오늘 날짜 원 색상
        calendar.appearance.selectionColor = .clear
        calendar.appearance.todayColor = .clear
        // 요일 표시 언어 설정
        calendar.locale = Locale(identifier: "ko_KR")
        // 요일 색 설정 (e.g. 월화수)
        calendar.appearance.weekdayTextColor = .black
        
        // tableView
        tableView.dataSource = self
        tableView.delegate = self
        // todoTableViewCell
        let todoTableViewCell = UINib(nibName: "TodoTableViewCell", bundle: nil)
        tableView.register(todoTableViewCell, forCellReuseIdentifier: "TodoTableViewCell")
    }
    
    private func initData() {
        calendar.select(Date())
        let currentPageDate = calendar.currentPage
        currentMonth = DateManager.getMonth(from: currentPageDate)
    }
    
    private func action() {
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
        calendarHeight.constant = bounds.height// * heightRatio
        self.view.layoutIfNeeded()

    }
    
    /// 셀 반환
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        
        print(type(of: self), #function)
        let cell = calendar.dequeueReusableCell(withIdentifier: CalendarCell.description(), for: date, at: position) as! CalendarCell
        
        // 이번 저번 달 글씨 색
        let month = DateManager.getMonth(from: date)
        if month != currentMonth {
            cell.backImageView.alpha = 0.5
        }

        // 선택 날짜 표시
        let selectedDay = DateManager.getDay(from: calendar.selectedDate!)
        let day = DateManager.getDay(from: date)
        if selectedDay == day {
            cell.selectIndicator.alpha = 1
        } else {
            cell.selectIndicator.alpha = 0
        }
        let randomInt = Int.random(in: 1...100)
        if randomInt < 30 {
            let url = URL(string: "https://picsum.photos/200/300?random=\(randomInt)")
            cell.backImageView.kf.setImage(with: url, options: [.transition(.fade(0.5))])
        }

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
        
    /// 선택 날짜 타이틀 색상
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleSelectionColorFor date: Date) -> UIColor? {
        // TODO: - 저번 or 다음 달이면 타이틀 회색
        
        // 이번 저번 달 글씨 색
        let selectedMonth = DateManager.getMonth(from: calendar.selectedDate!)
        let month = DateManager.getMonth(from: date)
        if month != selectedMonth {
            
            return .systemGray4
        }
        
        // 날짜만 추출하여 비교
        if let now = DateManager.getDay(from: Date()),
           let selected = DateManager.getDay(from: date) {
            print(now, selected)
            if now == selected {
                print("날짜 같음")
                return UIColor(red: 17/255, green: 152/255, blue: 34/255, alpha: 1)
            } else {
                return .black
            }
        }
        return .black
    }
    
    /// 기본 날짜 타이틀 색상
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        // 날짜만 추출하여 비교
        
        // 이번 저번 달 글씨 색
        let selectedMonth = DateManager.getMonth(from: calendar.selectedDate!)
        let month = DateManager.getMonth(from: date)
        if month != selectedMonth {
            return .systemGray4
        }
        
        if let now = DateManager.getDay(from: Date()),
           let selected = DateManager.getDay(from: date) {
            print(now, selected)
            if now == selected {
                print("날짜 같음")
                return UIColor(red: 17/255, green: 152/255, blue: 34/255, alpha: 1)
            } else {
                return .black
            }
        }
        return .black
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        let currentPageDate = calendar.currentPage
        currentMonth = DateManager.getMonth(from: currentPageDate)
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
