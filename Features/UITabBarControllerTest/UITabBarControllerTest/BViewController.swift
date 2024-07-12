//
//  BViewController.swift
//  UITabBarControllerTest
//
//  Created by JDeoks on 6/30/24.
//

import UIKit

class BViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let vcC = UIViewController()
        vcC.modalPresentationStyle = .overFullScreen
        vcC.modalTransitionStyle = .crossDissolve
        vcC.view.backgroundColor = .green
        present(vcC, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
