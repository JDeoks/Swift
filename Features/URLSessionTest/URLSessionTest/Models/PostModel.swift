//
//  PostModel.swift
//  URLSessionTest
//
//  Created by JDeoks on 3/14/24.
//

import Foundation

struct PostModel: Codable {
    
    var id: Int
    var title: String
    var content: String
    var createdAt: Date
    var updatedAt: Date
    var userID: Int
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case content
        case createdAt
        case updatedAt
        case userID = "UserId"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // id
        self.id = try container.decode(Int.self, forKey: .id)
        
        // title
        self.title = try container.decode(String.self, forKey: .title)
        
        // content
        self.content = try container.decode(String.self, forKey: .content)
        
        // createdAt
        let createdAtStr = try container.decode(String.self, forKey: .createdAt)
        self.createdAt = DateManager.shared.dateFromString(createdAtStr) ?? Date()
        
        // updatedAt
        let updatedAtStr = try container.decode(String.self, forKey: .updatedAt)
        self.updatedAt = DateManager.shared.dateFromString(updatedAtStr) ?? Date()
        
        // userID
        self.userID = try container.decode(Int.self, forKey: .userID)
    }
    
}
