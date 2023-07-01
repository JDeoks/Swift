//
//  ViewController.swift
//  SubmitValue-Back
//
//  Created by 서정덕 on 2023/07/01.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func pushPrivacy(_ sender: Any) {
        guard let pvc = self.storyboard?.instantiateViewController(identifier: "PrivacyVC") as? PrivacyVC else {
            return
        }
        self.navigationController?.pushViewController(pvc, animated: true)
    }
    
}

