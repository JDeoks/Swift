//
//  SignUpViewController.swift
//  Chat
//
//  Created by JDeoks on 12/6/23.
//

import UIKit
import RxSwift
import RxCocoa
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    let disposeBag = DisposeBag()
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var passwordTextView: UITextField!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var cancleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        action()
    }
    
    func action() {
        signUpButton.rx.tap
            .subscribe { _ in
                self.registerUser()
            }
            .disposed(by: disposeBag)
        
        cancleButton.rx.tap
            .subscribe { _ in
                self.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }
        
    func registerUser() {
        guard let email = emailTextField.text, let password = passwordTextView.text, let name = nameTextField.text else {
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("SignUp Error: \(error.localizedDescription)")
                return
            }
            guard let authResult = authResult else {
                print("signUp 오류")
                return
            }
            self.addUserToDB(id: authResult.user.uid, name: name)
        }
    }
        
    func addUserToDB(id: String, name: String) {
        db.collection("users").document(id).setData([
          "name": name
        ])
    }
}
