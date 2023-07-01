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
        
        // 배열에서 마지막 두번째인 전 화면 가져옴
        guard let preVC = self.navigationController?.viewControllers[self.navigationController!.viewControllers.count - 2] as? PrivacyVC else {
            return
        }
        preVC.paramEmail = emailInput.text!
        preVC.paramMode = mode.isOn
        preVC.paramInterval = interval.value
        self.navigationController?.popViewController(animated: true)
    }
}
