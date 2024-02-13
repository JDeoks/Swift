//
//  ViewController.swift
//  FCMTest
//
//  Created by JDeoks on 2/13/24.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-\(title!)",
            AnalyticsParameterItemName: title!,
            AnalyticsParameterContentType: "cont",
        ])
    }

}

