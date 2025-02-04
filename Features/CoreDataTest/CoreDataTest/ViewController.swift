//
//  ViewController.swift
//  CoreDataTest
//
//  Created by JDeoks on 1/28/25.
//

import UIKit
import CoreData

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    let context = AppDelegate.viewContext
    let tweet = Tweet(context: context)
    tweet.text = "Hello, World!"
    tweet.created = Date()
    let joe = TwitterUser(context: context)
    joe.name = "Joe Schmo"
    tweet.tweeter = joe
    joe.tweetCount += 1
    
    if let joesTweets = joe.tweets as? Set<Tweet> {
      if joesTweets.contains(tweet) {
        print ("yes!")
      }
    }
    
    context.delete(tweet)
    
    if let joesTweets = joe.tweets as? Set<Tweet> {
      if joesTweets.contains(tweet) {
        print ("No!")
      }
    }
  }
  
  func querying() {
    let request: NSFetchRequest<TwitterUser> = TwitterUser.fetchRequest()
    let sortDescriptor = NSSortDescriptor(
      key: "screenName",
      ascending: true,
      selector: #selector(NSString.localizedStandardCompare(_:))
    )
  }
}

