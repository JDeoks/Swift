//
//  TableCalTableViewCell.swift
//  FSCalendarEx
//
//  Created by JDeoks on 6/2/24.
//

import UIKit
import RxSwift
import RxCocoa
import FSCalendar

class TableCalTableViewCell: UITableViewCell {

    var tableCalVC: TableCalViewController?
    
    @IBOutlet var calendarView: FSCalendar!
    @IBOutlet var calendarHeight: NSLayoutConstraint!
    
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        print(type(of: self), #function)

        super.awakeFromNib()
        initUI()
    }
    
    override func prepareForReuse() {
        print(type(of: self), #function)

        disposeBag = DisposeBag()
    }
    
    private func initUI() {
        print(type(of: self), #function)
        
        calendarView.dataSource = self
        calendarView.delegate = self
        guard let tableCalVC = self.tableCalVC else { return }
        print(tableCalVC.calendarMode.value)
        
//        calendarView.headerHeight = 1
//        calendarView.appearance.headerTitleColor = UIColor.clear
//        self.calendarHeight.constant = bounds.height - 24
//        self.layoutIfNeeded()
//        calendarView.calendarHeaderView.isHidden = true
//        calendarView.headerHeight = 6.0 // this makes some extra spacing, but you can try 0 or 1
//        self.layoutIfNeeded()

    }
    
    func bind() {
        print(type(of: self), #function)

        guard let tableCalVC = self.tableCalVC else { return }
        calendarView.setScope(tableCalVC.calendarMode.value, animated: false)
        tableCalVC.calendarMode
            .skip(1)
            .subscribe(onNext: { mode in
                self.calendarView.setScope(mode, animated: true)
            })
            .disposed(by: disposeBag)
        
        // 초기 높이 설정
//        calendarView.setScope(.week, animated: false)
        calendarView.calendarHeaderView.isHidden = true
        calendarView.headerHeight = 8
//        self.layoutIfNeeded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension TableCalTableViewCell: FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        print(type(of: self), #function)
        print("Height전", calendarHeight!)

        calendarHeight.constant = bounds.height
        print("layoutIfNeeded전", calendarHeight!)
        self.layoutIfNeeded()
        print("layoutIfNeeded 후", calendarHeight!)

        if let tableView = self.superview as? UITableView {
            // ViewController의 calendarHeight 값을 업데이트합니다.
            if let viewController = tableCalVC {
//                viewController.calendarHeight = bounds.height
//                UIView.animate(withDuration: 0.3) {
//                    tableView.beginUpdates()
//                    tableView.endUpdates()
//                }
                tableView.beginUpdates()
                tableView.endUpdates()
            }
        }
        print("마지막", calendarHeight)
    }
}
