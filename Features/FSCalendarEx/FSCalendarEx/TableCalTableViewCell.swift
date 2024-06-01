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
    
    let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    // MARK: - initUI
    private func initUI() {
        calendarView.dataSource = self
        calendarView.delegate = self
    }
    
    // MARK: - bind
    func bind() {
        if let tableCalVC = self.tableCalVC {
            tableCalVC.calendarMode
                .subscribe(onNext: { [weak self] mode in
                    if mode == .month {
                        self?.calendarView.setScope(.month, animated: true)
                    } else {
                        self?.calendarView.setScope(.week, animated: true)
                    }
                })
                .disposed(by: disposeBag)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension TableCalTableViewCell: FSCalendarDataSource, FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        
        print(#function, bounds)
        calendarHeight.constant = bounds.height
        self.layoutIfNeeded()
    }
}
