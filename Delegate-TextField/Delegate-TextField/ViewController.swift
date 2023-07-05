//
//  ViewController.swift
//  Delegate-TextField
//
//  Created by 서정덕 on 2023/07/05.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var textTextField: UITextField!
    
    @IBAction func inputBtnClicked(_ sender: Any) {
        self.textTextField.becomeFirstResponder()
    }
    
    @IBAction func confirmBtnClicked(_ sender: Any) {
        // FirstResponder 해제
        self.textTextField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        uiInit()
        print("안녕")
        // textTextField를 FirstResponder로 설정
        self.textTextField.becomeFirstResponder()
        self.textTextField.delegate = self
        
    }

    func uiInit(){
        // 힌트 메시지
        self.textTextField.placeholder = "값을 입력하세요"
        // 키보드 타입
        self.textTextField.keyboardType = .alphabet
        // 키보드 다크모드로
        self.textTextField.keyboardAppearance = .dark
        // 엔터키 타입
        self.textTextField.returnKeyType = .join
        // 텍스트 필드가 비었을 때 엔터 비활성화
        self.textTextField.enablesReturnKeyAutomatically = true
        // 테두리 직선
        self.textTextField.borderStyle = .line
        // 배경 색
        self.textTextField.backgroundColor = UIColor(white: 0.87, alpha: 1.0)
        // 텍스트 수직 방항가운데 정렬
        self.textTextField.contentVerticalAlignment = .center
        // 텍스트 수평 방향 가운데 정렬
        self.textTextField.contentHorizontalAlignment = .center
        // 테두리 회색
        self.textTextField.layer.borderColor = UIColor.darkGray.cgColor
        // 테두리 두께
        self.textTextField.layer.borderWidth = 2.0
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("텍스트 편집이 시작될 때 호출")
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("텍스트 필드 내용 삭제될 때 호출")
        return true
    }
    
    // 내용이 변경될 때 호출
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("내용이 \(string)으로 변경 됨")
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("텍스트 필드의 리턴키가 눌렸을 때 호출")
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("편집이 종료될때 호출")
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("텍스트 필드의 편집 종료 후 호출")
    }
    
}

