//
//  ViewController.swift
//  PHPickerTest
//
//  Created by JDeoks on 2/19/24.
//

import UIKit
import PhotosUI

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectImageButtonClicked(_ sender: Any) {
        let uploadVC = self.storyboard?.instantiateViewController(identifier: "UploadViewController") as! UploadViewController
        uploadVC.modalPresentationStyle = .overFullScreen
//        uploadVC.modalTransitionStyle = .crossDissolve
        present(uploadVC, animated: true)
    }
}
