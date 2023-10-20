//
//  SecondVC.swift
//  SubmitValue-Back
//
//  Created by 서정덕 on 2023/07/04.
//

import UIKit

class SecondVC: UIViewController {
    
    var firstVC: FirstVC? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.modalTransitionStyle = .coverVertical
        self.dismiss(animated: true)
    }
    
    @IBAction func navBackButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
