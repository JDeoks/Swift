//
//  Tweet.swift
//  CoreDataTest
//
//  Created by JDeoks on 1/28/25.
//

import UIKit
import CoreData

class Tweet: NSManagedObject {

  override func prepareForDeletion() {
    self.tweeter?.tweetCount -= 1
  }
}
