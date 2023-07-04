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
    @IBOutlet var logInbtn: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        uiInit()

    }
    
    func uiInit() {
        usernameStack?.layer.borderWidth = 0.8
        usernameStack?.layer.borderColor = UIColor(hexCode: "DE1F43").cgColor
        usernameStack.layer.cornerRadius = usernameStack.frame.height/2

        passwordStack?.layer.borderWidth = 0.8
        passwordStack?.layer.borderColor = UIColor(hexCode: "DE1F43").cgColor
        passwordStack.layer.cornerRadius = passwordStack.frame.height/2

        logInbtn.layer.cornerRadius = logInbtn.frame.height/2
    }
    
    @IBAction func gotoSignUp(_ sender: Any) {
        guard let signUpVC =  self.storyboard?.instantiateViewController(identifier: "SignUpVC") as? SignUpVC else {
            return
        }
        signUpVC.modalPresentationStyle = .fullScreen
        present(signUpVC, animated: true)
    }
}

