//
//  ViewController3.swift
//  FSCalendarEx
//
//  Created by JDeoks on 6/4/24.
//

import UIKit
import FSCalendar

/// 캘린더 높이 설정
class ViewController3: UIViewController {

    @IBOutlet var calendar: FSCalendar!
    @IBOutlet var calendarHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        calendar.delegate = self
//        calendar.dataSource = self
////        calendar.scope = .week
//        calendar.register(CalendarCell.self, forCellReuseIdentifier: CalendarCell.description())
//        calendar.backgroundColor = .systemMint
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        if calendar.scope == .week {
            calendar.setScope(.month, animated: true)
        } else {
            calendar.setScope(.week, animated: true)
        }
        
    }
    


}

extension ViewController3: FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    /// 셀  생성
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        
        print(type(of: self), #function)
        let cell = calendar.dequeueReusableCell(withIdentifier: CalendarCell.description(), for: date, at: position) as! CalendarCell
        print(type(of: self), #function, cell.frame)
//        cell.backgroundColor = .red
        return cell
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        
        print(calendar.cell(for: Date(), at: .current)?.frame)
        print(type(of: self), #function, bounds.height)
        if calendar.scope == .week {
            calendarHeight.constant = 400
        } else {
            calendarHeight.constant = bounds.height
        }
        
//        calendarHeight.constant = bounds.height// * heightRatio
        self.view.layoutIfNeeded()

    }
    
}
