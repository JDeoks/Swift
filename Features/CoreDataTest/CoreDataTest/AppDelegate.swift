//
//  AppDelegate.swift
//  CoreDataTest
//
//  Created by JDeoks on 1/28/25.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  static let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
  // MARK: - Core Data stack
  lazy var persistentContainer: NSPersistentContainer = {
      /*
       애플리케이션의 Persistent Container입니다. 이 구현은
       애플리케이션을 위한 저장소를 로드하고 이를 포함하는 컨테이너를 생성하여 반환합니다.
       저장소 생성이 실패할 수 있는 합당한 이유가 있기 때문에 이 속성은 선택적(optional)입니다.
      */
      let container = NSPersistentContainer(name: "CoreDataTestModel")
      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
          if let error = error as NSError? {
              // 이 구현을 적절하게 오류를 처리하는 코드로 교체하세요.
              // fatalError()는 애플리케이션이 크래시 로그를 생성하고 종료되도록 합니다.
              // 이는 개발 중에는 유용할 수 있지만, 배포용 애플리케이션에서는 사용하지 않는 것이 좋습니다.
               
              /*
               여기에서 오류가 발생하는 일반적인 이유는 다음과 같습니다:
               * 상위 디렉터리가 존재하지 않거나 생성할 수 없거나 쓰기를 허용하지 않는 경우.
               * Persistent Store가 권한 문제나 장치가 잠겨 있을 때의 데이터 보호 때문에 접근할 수 없는 경우.
               * 장치에 저장 공간이 부족한 경우.
               * 현재 모델 버전으로 저장소를 마이그레이션할 수 없는 경우.
               오류 메시지를 확인하여 실제 문제가 무엇인지 파악하세요.
               */
              fatalError("해결되지 않은 오류 \(error), \(error.userInfo)")
          }
      })
      return container
  }()

  // MARK: - Core Data Saving support

  func saveContext () {
      let context = persistentContainer.viewContext
      if context.hasChanges {
          do {
              try context.save()
          } catch {
              // Replace this implementation with code to handle the error appropriately.
              // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
              let nserror = error as NSError
              fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
          }
      }
  }

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
