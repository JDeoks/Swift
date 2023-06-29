//
//  ViewController.swift
//  StoryboardTest
//
//  Created by 서정덕 on 2023/06/27.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var usernameStack: UIStackView!
    @IBOutlet var passwordStack: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        usernameStack?.layer.borderWidth = 0.5
        usernameStack?.layer.borderColor = UIColor.red.cgColor
        passwordStack?.layer.borderWidth = 0.5
        passwordStack?.layer.borderColor = UIColor.red.cgColor
    }
}

