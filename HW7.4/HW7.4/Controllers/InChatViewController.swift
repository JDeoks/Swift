//
//  InChatViewController.swift
//  HW7.4
//
//  Created by 서정덕 on 2023/07/07.
//

import UIKit
import SnapKit

class InChatViewController: UIViewController, UITextFieldDelegate {
    
    var stackViewBottomConstraint: Constraint?
    var originBottomY: CGFloat = 0.0

    @IBOutlet var messageTextStack: UIStackView!
    @IBOutlet var chatPartnerNameLabel: UILabel!
    @IBOutlet var messageTextField: UITextField!
    
    var paramChatPartnerName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        
        messageTextField.delegate = self
        originBottomY = self.messageTextStack.frame.origin.y
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
    
    // keyboardWillShowNotification 알림을 받으면 사용하도록 만든 셀렉터 메소드
    @objc func keyboardWillAppear(notification: NSNotification){
        print("InChatViewController - keyboardWillAppear")
        
        // 키보드 애니메이션 지속시간
        guard let keyboardAnimationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else {
            return
        }
        // 키보드 애니메이션 커브 저장
        let animationCurveRawValue: Int = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int ?? 0
        let animationCurve: UIView.AnimationCurve = UIView.AnimationCurve(rawValue: animationCurveRawValue) ?? .easeInOut
        
        // 애니메이션 속도를 키보드 애니메이션과 동일한 애니메이션 곡선으로 설정
        UIView.setAnimationCurve(animationCurve)
        
        // 키보드의 최종 프레임 정보를 나타내는 UserInfoKey
        guard let keyboardSize: CGRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        // 제약 조건 업데이트
        messageTextStack.snp.updateConstraints { make in
            make.bottom.equalToSuperview().inset(keyboardSize.height)
        }
        
        // 뷰 애니메이션 블록 내에서 애니메이션 실행
        UIView.animate(withDuration: keyboardAnimationDuration) {
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
        
        // 애니메이션 속도를 키보드 애니메이션과 동일한 애니메이션 곡선으로 설정
        UIView.setAnimationCurve(animationCurve)
        
        // 제약 조건 업데이트
        messageTextStack.snp.updateConstraints { make in
            make.bottom.equalToSuperview()
        }
        
        // 뷰 애니메이션 블록 내에서 애니메이션 실행
        UIView.animate(withDuration: keyboardAnimationDuration) {
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
    @IBAction func backButtonCliked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func initUI() {
        chatPartnerNameLabel.text = paramChatPartnerName
        messageTextField.layer.cornerRadius = messageTextField.frame.height * 0.35
        messageTextField.clipsToBounds = true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
