//
//  UserModel.swift
//  Chat
//
//  Created by JDeoks on 12/10/23.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAnalytics
import SwiftDate

class UserModel {
    
    /// user Doc 고유 아이디
    var userID: String
    var creationTime: Date
    var name: String
    var profileImageURL: URL?
    
    init(document: QueryDocumentSnapshot) {
        self.userID = document.documentID
        self.name = document.data()["name"] as! String
        self.creationTime = (document.data()["creationTime"] as! Timestamp).dateValue()
        let urlStr = document.data()["profileImageURL"] as! String
        self.profileImageURL = urlStr != "" ? URL(string: urlStr) : nil
    }
    
    func getCreationTimeStr() -> String {
        let region = Region(calendar: Calendars.gregorian, zone: Zones.asiaSeoul, locale: Locales.korean)
        return DateInRegion(self.creationTime, region: region).toFormat("yyyy-MM-dd HH:mm")
    }
}
