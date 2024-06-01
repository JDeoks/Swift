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

class ViewController: UIViewController {

    private var calanderMode: CalendarMode = .week
    
    @IBOutlet var monthButtonStackView: UIStackView!
    @IBOutlet var calendarView: FSCalendar!
    @IBOutlet var calendarHeight: NSLayoutConstraint!
    @IBOutlet var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        action()
    }
    
    private func initUI() {
        // calander
        calendarView.dataSource = self
        calendarView.delegate = self
        calendarView.scope = .week
        calendarView.calendarHeaderView.isHidden = true
        calendarView.headerHeight = 6.0
    }
    
    private func action() {
        monthButtonStackView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                print("monthButtonStackView.rx.tapGesture()")
                if self.calanderMode == .month {
                    self.calanderMode = .week
                    self.calendarView.setScope(.week, animated: true)
                } else {
                    self.calanderMode = .month
                    self.calendarView.setScope(.month, animated: true)
                }
                
            })
            .disposed(by: disposeBag)
    }

}

extension ViewController: FSCalendarDataSource, FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        if calendar.scope == .week {
                    // 일주일 단위일 때는 높이를 맞게 설정
                    calendarHeight.constant = bounds.height
                }
                else if calendar.scope == .month {
                    // 한달 단위일 때는 높이를 전체화면으로 설정
                    calendarHeight.constant = self.view.bounds.height
                }

        self.view.layoutIfNeeded()
    }
}


