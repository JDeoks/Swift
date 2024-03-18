//
//  DateManager.swift
//  URLSessionTest
//
//  Created by JDeoks on 3/14/24.
//

import Foundation

class DateManager {
    
    static let shared = DateManager()
    
    private let dateFormatter: DateFormatter
    
    private init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
    }
    
    func dateFromString(_ dateString: String) -> Date? {
        return dateFormatter.date(from: dateString)
    }
    
    func stringFromDate(_ date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
}
