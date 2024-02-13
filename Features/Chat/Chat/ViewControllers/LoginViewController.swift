//
//  LoginViewController.swift
//  Chat
//
//  Created by JDeoks on 12/6/23.
//

import UIKit
import RxSwift
import RxCocoa
import FirebaseAuth

class LoginViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextView: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        action()
        bind()
//        try? Auth.auth().signOut()
    }
    
    func action() {
        loginButton.rx.tap
            .subscribe { _ in
                self.performLogin()
            }
            .disposed(by: disposeBag)
        
        signInButton.rx.tap
            .subscribe { _ in
                let signUpVC = self.storyboard?.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
                signUpVC.modalPresentationStyle = .overFullScreen
                self.present(signUpVC, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    func bind() {
        Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                let mainVC = self.storyboard?.instantiateViewController(identifier: "MainTabBarController") as! UITabBarController
                mainVC.modalPresentationStyle = .overFullScreen
                self.present(mainVC, animated: true)
                print(user)
            }
        }
    }
    
    func performLogin() {
        print("LoginViewController - performLogin")
        guard let email = emailTextField.text, let password = passwordTextView.text else {
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
            if let error = error {
                print("performLogin 오류\(error)")
                self.showLoginErrorAlert(title: "로그인 오류", message: error.localizedDescription.debugDescription)
            }
        }
    }
    
    func showLoginErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in print("yes 클릭") }))
        self.present(alert, animated: true)
    }

}
