//
//  InChatViewController.swift
//  HW7.4
//
//  Created by 서정덕 on 2023/07/07.
//

import UIKit

class InChatViewController: UIViewController, UITextFieldDelegate {

    var originBottomY: CGFloat = 0.0

    @IBOutlet var messageTextStack: UIStackView!
    @IBOutlet var chatPartnerNameLabel: UILabel!
    @IBOutlet var messageTextField: UITextField!
    
    var paramChatPartnerName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiInit()
        
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
        // keyboardWillShowNotification, keyboardWillShowNotification에 대한 옵저버에서 self 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    // keyboardWillShowNotification 알림을 받으면 사용하도록 만든 셀렉터 메소드
    @objc func keyboardWillAppear(notification: NSNotification){
        // 키보드의 최종 프레임 정보를 나타내는 UserInfoKey
        guard let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        print("InChatViewController - keyboardWillAppear")
        
        if self.messageTextStack.frame.origin.y == originBottomY {
            self.messageTextStack.frame.origin.y -= keyboardFrame.cgRectValue.height + 34
        }
        
//        print("notification.userInfo: \(notification.userInfo!)")
//        print("keyboardFrame: \(keyboardFrame)")
//        print("")
//        // messageTextStack의 하단 Y 좌표
//        let messageStackBottomY = messageTextStack.frame.origin.y + messageTextStack.frame.size.height
//        // 키보드의 상단 Y 좌표
//        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
//        let keyboardHeight = keyboardFrame.cgRectValue.height
//        if messageStackBottomY > keyboardTopY {
//            print("messageTextStack is hidden by keyboard")
//            self.messageTextStack.frame.origin.y -= keyboardHeight
//            self.messageTextStack.frame.origin.y += 34
//        } else {
//            print("messageTextStack is not hidden by keyboard")
//        }
    }
    // keyboardWillHideNotification 알림을 받으면 사용하도록 만든 셀렉터 메소드
    @objc func keyboardWillDisappear(notification: NSNotification){
//        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//            let keyboardHeight = keyboardFrame.cgRectValue.height
//            self.messageTextStack.frame.origin.y += keyboardHeight
//            self.messageTextStack.frame.origin.y -= 34
//        }
        guard let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
//        self.messageTextStack.frame.origin.y += keyboardFrame.cgRectValue.height - 34
        //            self.messageTextStack.frame.origin.y -= 34
        self.messageTextStack.frame.origin.y = originBottomY
        print("InChatViewController - keyboardWillDisappear")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
    @IBAction func backButtonCliked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func uiInit() {
        chatPartnerNameLabel.text = paramChatPartnerName
        messageTextField.layer.cornerRadius = messageTextField.frame.height / 2
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
