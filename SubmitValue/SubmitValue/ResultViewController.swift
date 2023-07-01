//
//  ResultViewController.swift
//  SubmitValue
//
//  Created by 서정덕 on 2023/07/01.
//

import Foundation
import UIKit

class ResultViewController: UIViewController{
    
    @IBOutlet var emailText: UILabel!
    @IBOutlet var modeText: UILabel!
    @IBOutlet var intervalText: UILabel!
    
    var paramEmail: String = ""
    var paramMode: Bool = false
    var paramInterval: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(paramEmail, paramMode, paramInterval)
        emailText.text = paramEmail
        modeText.text = paramMode ? "갱신함" : "갱신하지 않음"
        let value: Int = Int(paramInterval)
        intervalText.text = "\(value)분마다"
    }
    
    @IBAction func onBack(_ sender: Any) {
        dismiss(animated: true)
    }
}
