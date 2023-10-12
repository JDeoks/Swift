//
//  ViewController.swift
//  HowlTalk
//
//  Created by 서정덕 on 2023/07/16.
//

import UIKit
import SnapKit
import Firebase

class ViewController: UIViewController {
    var remoteConfig: RemoteConfig!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.\\
        
        
        let remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        
        remoteConfig.fetch { (status, error) -> Void in
          if status == .success {
            print("Config fetched!")
            self.remoteConfig.activate { changed, error in
              // ...
            }
          } else {
            print("Config not fetched")
            print("Error: \(error?.localizedDescription ?? "No error available.")")
          }
          self.displayWelcome()
        }
    }
    
    func displayWelcome() {
    
    }


}

