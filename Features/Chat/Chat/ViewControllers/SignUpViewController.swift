//
//  SignUpViewController.swift
//  Chat
//
//  Created by JDeoks on 12/6/23.
//

import UIKit
import PhotosUI
import RxSwift
import RxCocoa
import RxGesture
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class SignUpViewController: UIViewController {
    
    var profileImage: UIImage! = nil
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    let didFinishPickingDone = PublishSubject<Void>()
    let disposeBag = DisposeBag()
    
    @IBOutlet var imageSelectButtonImageView: UIImageView!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var passwordTextView: UITextField!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var cancleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        action()
        bind()
    }
    func initUI() {

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
        
        imageSelectButtonImageView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                self.presentPicker()
            })
            .disposed(by: disposeBag)
    }
    
    func bind() {
        didFinishPickingDone
            .subscribe { _ in
                DispatchQueue.main.async {
                    self.imageSelectButtonImageView.contentMode = .scaleAspectFill
                    self.imageSelectButtonImageView.image = self.profileImage
                }
            }
            .disposed(by: disposeBag)
    }
    
    /// 사진,  이메일, 이름, 비밀번호로 회원가입
    func registerUser() {
        print("registerUser")
        guard
            let email = emailTextField.text,
            let password = passwordTextView.text,
            let userName = nameTextField.text else {
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let authResult = authResult {
                print("registerUser 성공")
                self.addUserInfoToDB(id: authResult.user.uid, userName: userName)
            }
            if let error = error {
                print("SignUp Error: \(error.localizedDescription)")
                return
            }
            guard let authResult = authResult else {
                print("signUp 오류")
                return
            }
        }
    }
        
    func addUserInfoToDB(id: String, userName: String) {
        print("addUserInfoToDB - id: \(id) userName: \(userName)")
        guard let image = profileImage else {
            self.addUserToDB(id: id, userName: userName, imageURL: "")
            return
        }
        let imageData = profileImage.jpegData(compressionQuality: 0.2)!
        
        let uploadRef = storage.reference().child("userImages").child(id)
        let uploadTask = uploadRef.putData(imageData, metadata: nil) { (metadata, error) in
            if let error = error {
                print("addProfileImageToDB 오류")
            }
        }
        uploadRef.downloadURL { (url, error) in
            guard let downloadURL = url else {
              return
            }
            let imageURL = downloadURL.absoluteString
            self.addUserToDB(id: id, userName: userName, imageURL: imageURL)
        }
    }
    
    /// 유저 Doc 생성
    func addUserToDB(id: String, userName: String, imageURL: String) {
        print("addUserToDB - id: \(id) userName: \(userName) imageURL: \(imageURL)")
        db.collection("users").document(id).setData([
          "userName": userName,
          "profileImageURL": imageURL
        ]){ err in
            if let err = err {
              print("Error writing document: \(err)")
            } else {
              print("Document successfully written!")
            } 
          }
    }
    
}

extension SignUpViewController: PHPickerViewControllerDelegate {
// MARK: PHPickerViewController
    
    func presentPicker() {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        
        let imagePicker = PHPickerViewController(configuration: config)
        imagePicker.delegate = self
        
        self.present(imagePicker, animated: true)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        let itemProviders = results.map(\.itemProvider)
        DispatchQueue.global().async {
            for itemProvider in itemProviders {
                if itemProvider.canLoadObject(ofClass: UIImage.self) {
                    itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                        guard let self = self, let image = image as? UIImage else { return }
                        self.profileImage = image
                        self.didFinishPickingDone.onNext(())
                    }
                }
            }

        }
        picker.dismiss(animated: true)
    }
}
