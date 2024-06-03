//
//  Date+.swift
//  FSCalendarEx
//
//  Created by JDeoks on 6/4/24.
//

import Foundation

extension Date {
    var dayStr: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d" 
        return formatter.string(from: self)
    }
}
