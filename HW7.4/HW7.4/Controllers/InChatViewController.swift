//
//  InChatViewController.swift
//  HW7.4
//
//  Created by 서정덕 on 2023/07/07.
//

import UIKit
import SnapKit

class InChatViewController: UIViewController {

    @IBOutlet var messageTextStack: UIStackView!
    @IBOutlet var chatPartnerNameLabel: UILabel!
    @IBOutlet var messageTextField: UITextField!
    
    var paramChatPartnerName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        
        messageTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // keyboardWillShowNotification,keyboardWillHideNotification에 대한 옵저버로 self 등록
        // 등록한 옵저버는 keyboardWillAppear(notification:)와 keyboardWillDisappear(notification:)를 호출함
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // keyboardWillShowNotification, keyboardWillHideNotification에 대한 옵저버에서 self 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func initUI() {
        chatPartnerNameLabel.text = paramChatPartnerName
        messageTextField.layer.cornerRadius = messageTextField.frame.height * 0.35
        messageTextField.clipsToBounds = true
    }
    
    // keyboardWillShowNotification 알림을 받으면 사용하도록 만든 셀렉터 메소드
    @objc func keyboardWillAppear(notification: NSNotification){
        print("InChatViewController - keyboardWillAppear")
        
        // 키보드의 최종 프레임 정보를 나타내는 UserInfoKey
        guard let keyboardSize: CGRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        // 키보드 애니메이션 지속시간
        guard let keyboardAnimationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else {
            return
        }
        // 키보드 애니메이션 커브 저장
        let animationCurveRawValue: Int = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int ?? 0
        let animationCurve: UIView.AnimationCurve = UIView.AnimationCurve(rawValue: animationCurveRawValue) ?? .easeInOut
        
        // messageTextStack 애니메이션 속성 설정
        UIView.animate(withDuration: keyboardAnimationDuration, delay: 0, options: [UIView.AnimationOptions(rawValue: UInt(animationCurve.rawValue))]) {
            // 제약 조건 업데이트
            self.messageTextStack.snp.updateConstraints { make in
                make.bottom.equalToSuperview().inset(keyboardSize.height)
            }
            
            // 화면 레이아웃 업데이트
            self.view.layoutIfNeeded()
        }
    }
    
    // keyboardWillHideNotification 알림을 받으면 사용하도록 만든 셀렉터 메소드
    @objc func keyboardWillDisappear(notification: NSNotification){
        print("\nInChatViewController - keyboardWillDisappear")

        // 키보드 애니메이션 지속시간
        guard let keyboardAnimationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else {
            return
        }
        // 키보드 애니메이션 커브 저장
        let animationCurveRawValue: Int = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int ?? 0
        let animationCurve: UIView.AnimationCurve = UIView.AnimationCurve(rawValue: animationCurveRawValue) ?? .easeInOut

        // messageTextStack 애니메이션 속성 설정
        UIView.animate(withDuration: keyboardAnimationDuration, delay: 0, options: [UIView.AnimationOptions(rawValue: UInt(animationCurve.rawValue))]) {
            // 제약 조건 업데이트
            self.messageTextStack.snp.updateConstraints { make in
                make.bottom.equalToSuperview()
            }
            
            // 화면 레이아웃 업데이트
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func backButtonCliked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}

extension InChatViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
