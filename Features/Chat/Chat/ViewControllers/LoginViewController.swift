//
//  LoginViewController.swift
//  Chat
//
//  Created by JDeoks on 12/6/23.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextView: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        action()
    }
    
    func action() {
        signInButton.rx.tap
            .subscribe { _ in
                let signUpVC = self.storyboard?.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
                signUpVC.modalPresentationStyle = .overFullScreen
                self.present(signUpVC, animated: true)
            }
            .disposed(by: disposeBag)
    }

}
