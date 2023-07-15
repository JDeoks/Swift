//
//  DataStore.swift
//  HW7.4
//
//  Created by 서정덕 on 2023/07/14.
//

class DataStore {
    
    var chatDataSet: [(String, String)] = [
        ("민수", "안녕하세요"),
        ("나영", "안녕하세요"),
        ("지현", "안녕하세요"),
        ("현우", "안녕하세요"),
        ("민수", "모두 잘 지내시나요?"),
        ("나영", "네, 잘 지내고 있어요"),
        ("지현", "네, 저도 괜찮아요"),
        ("현우", "네, 모두 안녕하세요!"),
        ("지현", "네, 저도 괜찮아요"),
        ("현우", "네, 모두 안녕하세요!"),
        ("현우", "안녕하세요"),
        ("민수", "모두 잘 지내시나요?"),
        ("나영", "네, 잘 지내고 있어요"),
        ("지현", "네, 저도 괜찮아요"),
        ("현우", "네, 모두 안녕하세요!"),
        ("민수", "안녕하세요"),
        ("나영", "안녕하세요"),
        ("지현", "네, 저도 괜찮아요"),
        ("현우", "네, 모두 안녕하세요!"),
        ("지현", "네, 저도 괜찮아요"),
        ("현우", "네, 모두 안녕하세요!"),
        ("현우", "안녕하세요"),
        ("민수", "모두 잘 지내시나요?"),
        ("나영", "네, 잘 지내고 있어요"),
        ("지현", "안녕하세요"),
        ("현우", "안녕하세요"),
        ("민수", "모두 잘 지내시나요?"),
    ]
    
    lazy var chatList: [ChatValueObject] = {
        var chatList: [ChatValueObject] = []
        for chatData in chatDataSet {
            let chat = ChatValueObject()
            chat.name = chatData.0
            chat.message = chatData.1
            chatList.append(chat)
        }
        return chatList
    }()
    
    static let shared = DataStore()
    
    private init() {
    }
    
    // 나머지 데이터 관련 속성 및 메서드
}
