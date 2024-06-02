//
//  DateManager.swift
//  FSCalendarEx
//
//  Created by JDeoks on 6/3/24.
//

import Foundation

class DateManager {
    static func getDay(from date: Date) -> Date? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return calendar.date(from: components)
    }
    
    static func getMonth(from date: Date) -> Date? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)
    }
}
