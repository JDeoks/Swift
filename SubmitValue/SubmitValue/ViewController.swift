//
//  ViewController.swift
//  SubmitValue
//
//  Created by 서정덕 on 2023/07/01.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var emailInput: UITextField!
    @IBOutlet var intervalText: UILabel!
    @IBOutlet var modeText: UILabel!
    @IBOutlet var mode: UISwitch!
    @IBOutlet var interval: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func changeMode(_ sender: UISwitch) {
        modeText.text = mode.isOn ? "갱신함" : "갱신하지 않음"
    }
    
    @IBAction func changeInterval(_ sender: UIStepper) {
        let value: Int = Int(interval.value)
        intervalText.text = "\(value)분마다"
    }

    @IBAction func onSubmit(_ sender: Any) {
        // rvc가 UIViewController이면 ResultViewController의 프로퍼티를 사용하지 못해서 형변환 필요
        guard let rvc = self.storyboard?.instantiateViewController(identifier: "RVC") as? ResultViewController else {
            return
        }
        
        // 만든 인스턴스에 값 전송
        rvc.paramEmail = emailInput.text!
        rvc.paramMode = mode.isOn
        rvc.paramInterval = interval.value
        rvc.modalPresentationStyle = .fullScreen
        self.present(rvc, animated: true)
    }
    @IBAction func submitByNav(_ sender: Any) {
        guard let rvc = self.storyboard?.instantiateViewController(identifier: "RVC") as? ResultViewController else {
            return
        }
        
        // 만든 인스턴스에 값 전송
        rvc.paramEmail = emailInput.text!
        rvc.paramMode = mode.isOn
        rvc.paramInterval = interval.value
        rvc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(rvc, animated: true)
    }
}

