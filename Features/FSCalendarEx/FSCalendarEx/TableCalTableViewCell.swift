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
        super.awakeFromNib()
        initUI()
    }
    
    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
    
    private func initUI() {
        calendarView.dataSource = self
        calendarView.delegate = self
    }
    
    func bind() {
        guard let tableCalVC = self.tableCalVC else { return }
        tableCalVC.calendarMode
            .subscribe(onNext: { mode in
                self.calendarView.setScope(mode, animated: true)
            })
            .disposed(by: disposeBag)
        
        // 초기 높이 설정
        calendarView.setScope(.week, animated: false)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension TableCalTableViewCell: FSCalendarDataSource, FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeight.constant = bounds.height
        self.layoutIfNeeded()
        
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
    }
}
