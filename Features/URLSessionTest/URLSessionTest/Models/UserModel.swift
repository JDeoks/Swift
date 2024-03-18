//
//  UserModel.swift
//  URLSessionTest
//
//  Created by JDeoks on 3/14/24.
//

import Foundation
/*
 {
   "id": 1,
   "name": "이정도",
   "username": "jd1386",
   "email": "lee.jungdo@gmail.com",
   "phone": "010-3192-2910",
   "website": "https://leejungdo.com",
   "province": "경기도",
   "city": "성남시",
   "district": "분당구",
   "street": "대왕판교로 160",
   "zipcode": "13525",
   "createdAt": "2019-02-24T16:17:47.000Z",
   "updatedAt": "2019-02-24T16:17:47.000Z"
 }
 */

struct UserModel: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let website: URL
    let province: String
    let city: String
    let district: String
    let street: String
    let zipcode: String
    let createdAt: Date
    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
        case email
        case phone
        case website
        case province
        case city
        case district
        case street
        case zipcode
        case createdAt
        case updatedAt
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // id
        self.id = try container.decode(Int.self, forKey: .id)
        // name
        self.name = try container.decode(String.self, forKey: .name)
        // username
        self.username = try container.decode(String.self, forKey: .username)
        // email
        self.email = try container.decode(String.self, forKey: .email)
        // phone
        self.phone = try container.decode(String.self, forKey: .phone)
        // website
        self.website = try container.decode(URL.self, forKey: .website)
        // province
        self.province = try container.decode(String.self, forKey: .province)
        // city
        self.city = try container.decode(String.self, forKey: .city)
        // district
        self.district = try container.decode(String.self, forKey: .district)
        // street
        self.street = try container.decode(String.self, forKey: .street)
        // zipcode
        self.zipcode = try container.decode(String.self, forKey: .zipcode)
        // createdAt
        let createdAtStr = try container.decode(String.self, forKey: .createdAt)
        self.createdAt = DateManager.shared.dateFromString(createdAtStr) ?? Date()
        // updatedAt
        let updatedAtStr = try container.decode(String.self, forKey: .updatedAt)
        self.updatedAt = DateManager.shared.dateFromString(updatedAtStr) ?? Date()
    }
}
