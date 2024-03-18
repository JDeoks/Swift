//
//  NetworkError.swift
//  URLSessionTest
//
//  Created by JDeoks on 3/15/24.
//

import Foundation

enum NetworkError: Error {
    case invalidTask
    case invalidURL
    case badConnection
    case invalidResponse
    case invalidData
    
    var errorMessage: String {
        switch self {
        case .invalidTask:
            return "잘못된 task"
        case .invalidURL:
            return "유효한 url이 아님."
        case .badConnection:
            return "연결 불량"
        case .invalidResponse:
            return "잘못된 응답"
        case .invalidData:
            return "잘못된 데이터"
        }
    }
}
