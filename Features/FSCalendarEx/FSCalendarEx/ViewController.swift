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
//    @IBOutlet var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        action()
        initData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calendar.collectionViewLayout.invalidateLayout()
    }
    
    private func initUI() {
        // calander
        calendar.dataSource = self
        calendar.delegate = self
        // 스코프 설정
        calendar.scope = .week
        // 헤더 없애기
//        calendar.calendarHeaderView.isHidden = true
//        calendar.headerHeight = 8
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
        calendar.clipsToBounds = false
        calendar.layer.masksToBounds = false
        
//        // TODO: - 버그
//        calendar.snp.makeConstraints { make in
//            let inset = calculateCalendarPadding(targetPadding: 20, contentWidth: 36)
//            make.leading.equalToSuperview().offset(inset)
//            make.trailing.equalToSuperview().offset(-inset).priority(1000)
//        } // 22일 에서 주단위로 보기 하면 셀 없어짐
//         self.view.layoutIfNeeded() //모든 셀에 밑줄 쳐짐
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
        if  (0...100).contains(Int(date.dayStr)!) {
            let url = URL(string: "https://picsum.photos/200?random=\(date.dayStr)")
            cell.backImageView.kf.setImage(with: url, options: [.transition(.fade(0.5))])
        }
        
        // 현재 달 날짜만 색 진하게 설정
        if position == .current {
            cell.backImageView.alpha = 1
            cell.dateLabel.alpha = 1
        } else {
            cell.backImageView.alpha = 0.2
            cell.dateLabel.alpha = 0.2
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
        
        // 선택한 날짜가 다른 달일 경우 이동
        if monthPosition == .next {
            let currentPage: Date = calendar.currentPage
            if let month = Calendar.current.date(byAdding: .month, value : 1, to: currentPage) {
                self.calendar.setCurrentPage(month, animated: true)
            }
        } else if monthPosition == .previous {
            let currentPage: Date = calendar.currentPage
            if let month = Calendar.current.date(byAdding: .month, value : -1, to: currentPage) {
                self.calendar.setCurrentPage(month, animated: true)
            }
        }
        
        guard let cell = calendar.cell(for: date, at: monthPosition) as? CalendarCell else {
            return
        }
        
        UIView.animate(withDuration: 0.2) {
            cell.selectIndicator.alpha = 1
        }
    }
    
    /// 선택 해제 시
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(type(of: self), #function)
        
        guard let cell = calendar.cell(for: date, at: monthPosition) as? CalendarCell else {
            return
        }
        UIView.animate(withDuration: 0.2) {
            cell.selectIndicator.alpha = 0
        }
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        print(type(of: self), #function, bounds.height)
        
        calendarHeight.constant = bounds.height
        self.view.layoutIfNeeded()
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        let currentPageDate = calendar.currentPage
        let month = Calendar.current.component(.month, from: currentPageDate)
        print("Current page month: \(month)")
        // Perform any actions you need based on the new current page
    }

        
    /// targetPadding을 만들기 위한 슈퍼뷰와 캘린더의 패딩 계산 하는 함수
    /// targetPadding: 목표하는 셀의 한쪽 패딩 + 캘린더 패딩 수치
    /// contentWidth: 셀의 컨텐프 너비 (패딩 제외)
    func calculateCalendarPadding(targetPadding: CGFloat, contentWidth: CGFloat) -> CGFloat {
        let w = self.view.bounds.width
        let x = (14 * targetPadding + 7 * contentWidth - w) / 12
        print(x)
        return x
    }
    
    
}
