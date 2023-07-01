//
//  ViewController.swift
//  Scene-Transition
//
//  Created by 서정덕 on 2023/06/29.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func moveNext(_ sender: Any) {
        let uvc: UIViewController? = self.storyboard?.instantiateViewController(identifier: "SecondVC")
        uvc?.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        self.present(uvc!, animated: true)
    }
    @IBAction func moveByNav(_ sender: Any) {
        guard let uvc = self.storyboard?.instantiateViewController(identifier: "SecondVC") else {
            return
        }
        self.navigationController?.pushViewController(uvc, animated: true)
    }
}

