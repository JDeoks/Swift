//
//  Date+Extensions.swift
//  voiceMemo
//

import Foundation

extension Date {
  
    var formattedTime: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "a hh:mm"
        return formatter.string(from: self)
    }
    
    var formattedDay: String {
        let now = Date()
        // 유저의 현재 캘린더
        let calender: Calendar = Calendar.current
        
        let nowStartedOfDay = calender.startOfDay(for: now)
        let dateStartOfDay = calender.startOfDay(for: self)
        let numOfDaysDifference: Int = calender.dateComponents([.day], from: nowStartedOfDay, to: dateStartOfDay).day!
        if numOfDaysDifference == 0 {
            return "오늘"
        } else {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ko_KR")
            formatter.dateFormat = "M월 d일 E요일"
            return formatter.string(from: self)
        }
    }
    
}
