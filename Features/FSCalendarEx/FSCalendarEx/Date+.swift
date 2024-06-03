//
//  Date+.swift
//  FSCalendarEx
//
//  Created by JDeoks on 6/4/24.
//

import Foundation

extension Date {
    /// day 부분 string을 0 없이 반환
    var dayStr: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d" 
        return formatter.string(from: self)
    }
    
    var monthStr: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M" // "MM"는 날짜의 월(month) 부분만 반환합니다
        return formatter.string(from: self)
    }

    var yearStr: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy" // "yyyy"는 날짜의 연(year) 부분만 반환합니다
        return formatter.string(from: self)
    }
    
    static func isSameDay(_ d1: Date, _ d2: Date) -> Bool {
        return Calendar.current.isDate(d1, inSameDayAs: d2)
    }
}
