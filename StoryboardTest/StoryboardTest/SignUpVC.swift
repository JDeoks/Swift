//
//  SignUpVC.swift
//  StoryboardTest
//
//  Created by 서정덕 on 2023/07/04.
//

import Foundation
import UIKit

class SignUpVC: UIViewController {
    @IBOutlet var firstNameText: UITextField!
    @IBOutlet var lastNameText: UITextField!
    @IBOutlet var emailText: UITextField!
    @IBOutlet var passwordStack: UIStackView!
    @IBOutlet var passwordText: UITextField!
    @IBOutlet var confirmPasswordStack: UIStackView!
    @IBOutlet var confirmPasswordText: UITextField!
    @IBOutlet var signUpBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiInit()
    }
    
    func uiInit() {
        firstNameText?.layer.borderWidth = 0.8
        firstNameText?.layer.borderColor = UIColor(hexCode: "DE1F43").cgColor
        firstNameText.layer.cornerRadius = firstNameText.frame.height/2
        lastNameText?.layer.borderWidth = 0.8
        lastNameText?.layer.borderColor = UIColor(hexCode: "DE1F43").cgColor
        lastNameText.layer.cornerRadius = lastNameText.frame.height/2
        emailText?.layer.borderWidth = 0.8
        emailText?.layer.borderColor = UIColor(hexCode: "DE1F43").cgColor
        emailText.layer.cornerRadius = emailText.frame.height/2
        passwordStack?.layer.borderWidth = 0.8
        passwordStack?.layer.borderColor = UIColor(hexCode: "DE1F43").cgColor
        passwordStack.layer.cornerRadius = passwordStack.frame.height/2
        confirmPasswordStack?.layer.borderWidth = 0.8
        confirmPasswordStack?.layer.borderColor = UIColor(hexCode: "DE1F43").cgColor
        confirmPasswordStack.layer.cornerRadius = confirmPasswordStack.frame.height/2

        signUpBtn.layer.cornerRadius = signUpBtn.frame.height/2
 }
    @IBAction func gotoSignIn(_ sender: Any) {
        print(self.prese)
        self.presentingViewController?.dismiss(animated: true)
    }
    
}
