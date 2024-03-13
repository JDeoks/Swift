//
//  main.swift
//  Play
//
//  Created by 서정덕 on 2023/10/19.
//

import Foundation

// MARK: - CustomKeyUser
struct CustomKeyUser: Codable {

    var name: String
    var age: Int
    var emailAddress: String

    private enum JSONKeys: String, CodingKey {
        case name
        case age
        case emailAddress = "email" // JSON에서는 "email", 모델에서는 "emailAddress"로 사용
    }
    
    init(from decoder: Decoder) throws {
        // JSONKeys를 키로 사용하는 컨테이너 생성
        let container = try decoder.container(keyedBy: JSONKeys.self)
        
        // 각 프로퍼티를 디코딩
        name = try container.decode(String.self, forKey: .name)
        age = try container.decode(Int.self, forKey: .age)
        emailAddress = try container.decode(String.self, forKey: .emailAddress)
    }
    
    init(name: String, age: Int, emailAddress: String) {
        self.name = name
        self.age = age
        self.emailAddress = emailAddress
    }
    
    // 커스텀 인코딩 구현
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: JSONKeys.self)
        
        // 기본 프로퍼티 인코딩
        try container.encode(name, forKey: .name)
        try container.encode(age, forKey: .age)
        
        // emailAddress를 "email" 키로 인코딩
        try container.encode(emailAddress, forKey: .emailAddress)
    }
    
}

// MARK: - CodingKeysUser
struct CodingKeysUser: Codable {

    var name: String
    var age: Int
    var emailAddress: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case age
        case emailAddress = "email" // JSON에서는 "email", 모델에서는 "emailAddress"로 사용
    }
    
}

func main() {
    // 커스텀키 인코딩
    let customKeyUser = CustomKeyUser(name: "홍길동", age: 24, emailAddress: "hong@example.com")
    guard let customKeyJSONString = encodeWithCustomKey(user: customKeyUser) else {
        return
    }
    print("커스텀키 인코딩")
    print(customKeyJSONString)
    
    // 커스텀 키 디코딩
    guard let decodedCustomKeyUser = decodeWithCustomKey(jsonString: customKeyJSONString) else {
        return
    }
    print("커스텀키 디코딩")
    print("name: \(decodedCustomKeyUser.name), age: \(decodedCustomKeyUser.age), emailAddress: \(decodedCustomKeyUser.emailAddress)")
    
    // CodingKeys 인코딩
    let codingKeysUser = CodingKeysUser(name: "홍길동", age: 24, emailAddress: "hong@example.com")
    guard let codingKeysJSONString = encodeWithCodingKeys(user: codingKeysUser) else {
        return
    }
    print("\nCodingKeys 인코딩")
    print(codingKeysJSONString)
    
    // CodingKeys 인코딩
    guard let decodedCodingKeysUser = decodeWithCodingKeys(jsonString: codingKeysJSONString) else {
        return
    }
    print("name: \(decodedCodingKeysUser.name), age: \(decodedCodingKeysUser.age), emailAddress: \(decodedCodingKeysUser.emailAddress)")
}

// MARK: - 커스텀키
/// 커스텀키 JSON 인코딩
func encodeWithCustomKey(user: CustomKeyUser) -> String? {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted

    // User 구조체의 encode(to:)가 내부적으로 호출
    guard let jsonData = try? encoder.encode(user) else {
        return nil
    }
    guard let jsonString = String(data: jsonData, encoding: .utf8) else {
        return nil
    }
    return jsonString
}

/// 커스텀키 JSON 디코딩
func decodeWithCustomKey(jsonString: String) -> CustomKeyUser? {
    guard let jsonData = jsonString.data(using: .utf8) else {
        return nil
    }
    // User 구조체의 init이 내부적으로 호출
    guard let user = try? JSONDecoder().decode(CustomKeyUser.self, from: jsonData) else {
        return nil
    }
    return user
}

// MARK: - CodingKeys
/// CodingKeys JSON 디코딩
func encodeWithCodingKeys(user: CodingKeysUser) -> String? {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    
    do {
        let jsonData = try encoder.encode(user)
        guard let jsonString = String(data: jsonData, encoding: .utf8) else {
            return nil
        }
        return jsonString
    } catch {
        print("인코딩 중 오류 발생: \(error)")
        return nil
    }
}

func decodeWithCodingKeys(jsonString: String) -> CodingKeysUser? {
    guard let jsonData = jsonString.data(using: .utf8) else {
        return nil
    }
    guard let user = try? JSONDecoder().decode(CodingKeysUser.self, from: jsonData) else {
        return nil
    }
    return user
}

main()
