//
//  ViewController.swift
//  RealmTest
//
//  Created by JDeoks on 2/5/25.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
  
  let realm = try! Realm()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    saveDefectWithImages()
    fetchAllDefects()
  }
  
  func saveDefectWithImages() {
    let defect = OfflineDefect()
    defect.id = UUID().uuidString
    defect.creationTime = Date()
    defect.site = "공사 현장 A"
    
    let image1 = OfflineImage()
    image1.id = UUID().uuidString
    image1.fileName = "image1_\(UUID().uuidString).jpg"
    image1.width = 1024.0
    image1.height = 768.0
    
    let image2 = OfflineImage()
    image2.id = UUID().uuidString
    image2.fileName = "image2_\(UUID().uuidString).jpg"
    image2.width = 800.0
    image2.height = 600.0
    
    defect.beforeImages.append(objectsIn: [image1, image2])
    
    try! realm.write {
      realm.add(defect)
    }
    print("✅ OfflineDefect + Images 저장 완료!")
  }
  
  func fetchAllDefects() {
    let defects = realm.objects(OfflineDefect.self)
    
    for defect in defects {
      print("🔹 Defect ID: \(defect.id ?? "N/A")")
      print("🔹 Site: \(defect.site ?? "N/A")")
      print("🔹 Before Images: \(defect.beforeImages.count)장\n")
    }
  }
  
  func fetchDefectByIDSorted(_ id: String) -> Results<OfflineDefect> {
    return realm.objects(OfflineDefect.self)
      .filter("id == %@", id)
      .sorted(byKeyPath: "creationTime", ascending: false)
  }
}


