//
//  OfflineImage.swift
//  RealmTest
//
//  Created by JDeoks on 2/5/25.
//

import Foundation
import RealmSwift

class OfflineImage: Object {
  
  enum Key {
    static let id = "id"
    static let fileName = "fileName"
    static let width = "width"
    static let height = "height"
  }
  
  @Persisted var id: String?
  @Persisted var fileName: String?
  @Persisted var width: Double = 0.0
  @Persisted var height: Double = 0.0
  
  @Persisted(originProperty: OfflineDefect.Key.beforeImages) var defect: LinkingObjects<OfflineDefect>
}
