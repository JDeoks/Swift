//
//  AppDelegate.swift
//  HW7.4
//
//  Created by 서정덕 on 2023/07/06.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

