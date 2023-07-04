//
//  PrivacyEditVC.swift
//  SubmitValue-Back
//
//  Created by 서정덕 on 2023/07/01.
//

import Foundation
import UIKit

class PrivacyEditVC: UIViewController {
    
    @IBOutlet var emailInput: UITextField!
    @IBOutlet var mode: UISwitch!
    @IBOutlet var intervalText: UILabel!
    @IBOutlet var interval: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func updateInterval(_ sender: UIStepper) {
        let value: Int = Int(interval.value)
        intervalText.text = "\(value)분 마다"
    }
    
    @IBAction func savePrivacy(_ sender: Any) {
//        sendByParam()
//        sendByAppDel()
        sendByUD()
        self.navigationController?.popViewController(animated: true)
    }
    
    /// 이전화면으로 직접 전달
    func sendByParam() {
        guard let preVC = self.navigationController?.viewControllers[self.navigationController!.viewControllers.count - 2] as? PrivacyVC else {
            return
        }
        preVC.paramEmail = emailInput.text!
        preVC.paramMode = mode.isOn
        preVC.paramInterval = interval.value
    }
    
    /// 앱 델리게이트 사용
    func sendByAppDel() {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        appDel.paramEmail = emailInput.text!
        appDel.paramMode = mode.isOn
        appDel.paramInterval = interval.value
    }
    
    /// UserDefaults 사용
    func sendByUD() {
        let ud = UserDefaults.standard
        ud.set(emailInput.text!, forKey: "email")
        ud.set(mode.isOn, forKey: "mode")
        ud.set(interval.value, forKey: "interval")
    }
    
}
