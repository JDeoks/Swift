//
//  PrivacyVC.swift
//  SubmitValue-Back
//
//  Created by 서정덕 on 2023/07/01.
//

import Foundation
import UIKit

class PrivacyVC: UIViewController{
    
    @IBOutlet var emailText: UILabel!
    @IBOutlet var autoUpdateText: UILabel!
    @IBOutlet var intervalText: UILabel!
    
    var paramEmail: String = ""
    var paramMode: Bool = false
    var paramInterval: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 뷰가 다시 보이기 전에 전달 받은 값을 뷰에 적
        emailText.text = paramEmail
        autoUpdateText.text = paramMode ? "갱신함": "갱신하지 않음"
        intervalText.text = "\(Int(paramInterval))분 마다"
    }
    
    @IBAction func editPrivacy(_ sender: Any) {
        guard let editVC = self.storyboard?.instantiateViewController(identifier: "PrivacyEditVC") as? PrivacyEditVC else {
            return
        }
        self.navigationController?.pushViewController(editVC, animated: true)
    }
}
