//
//  OfflineDefect.swift
//  RealmTest
//
//  Created by JDeoks on 2/5/25.
//

import Foundation
import RealmSwift

class OfflineDefect: Object {
  
  enum Key {
    static let id = "id"
    static let creationTime = "creationTime"
    
    static let teamID = "teamID"

    static let requesterID = "requesterID"
    static let requesterName = "requesterName"
    static let requesterPhone = "requesterPhone"
    
    static let site = "site"
    static let building = "building"
    static let unit = "unit"
    static let space = "space"
    static let part = "part"
    static let workType = "workType"
    
    static let beforeDescription = "beforeDescription"

    static let beforeImages = "beforeImages"
  }
  
  @Persisted var id: String?
  @Persisted var creationTime: Date?
  
  @Persisted var teamID: String?
  
  @Persisted var requesterID: String?
  @Persisted var requesterName: String?
  @Persisted var requesterPhone: String?
  
  @Persisted var site: String?
  @Persisted var building: String?
  @Persisted var unit: String?
  @Persisted var space: String?
  @Persisted var part: String?
  @Persisted var workType: String?
  
  @Persisted var beforeDescription: String?

  @Persisted var beforeImages: List<OfflineImage>
}
