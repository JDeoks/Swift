//
//  ViewController.swift
//  UITabBarControllerTest
//
//  Created by JDeoks on 6/30/24.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let vcB = BViewController()
        vcB.view.backgroundColor = .red
        self.navigationController?.pushViewController(vcB, animated: true)
//        let vcC = UIViewController()
//        vcC.view.backgroundColor = .blue
//        vcB.present(vcC, animated: true)
    }
    
}
