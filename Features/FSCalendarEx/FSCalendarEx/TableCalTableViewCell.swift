//
//  TableCalTableViewCell.swift
//  FSCalendarEx
//
//  Created by JDeoks on 6/2/24.
//

import UIKit
import FSCalendar

class TableCalTableViewCell: UITableViewCell {

    @IBOutlet var calendarView: FSCalendar!
    @IBOutlet var calendarHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func initUI() {
        calendarView.dataSource = self
        calendarView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension TableCalTableViewCell: FSCalendarDataSource, FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        if calendar.scope == .week {
                    // 일주일 단위일 때는 높이를 맞게 설정
                    calendarHeight.constant = bounds.height
                }
                else if calendar.scope == .month {
                    // 한달 단위일 때는 높이를 전체화면으로 설정
                    calendarHeight.constant = self.bounds.height
                }

        self.layoutIfNeeded()
    }
}
