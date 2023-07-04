//
//  FirstVC.swift
//  SubmitValue-Back
//
//  Created by 서정덕 on 2023/07/04.
//

import UIKit

class FirstVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func moveButtonClicked(_ sender: Any) {
        // presentSecondVC()
        pushSecondVC()
    }
    
    func presentSecondVC() {
        let secondVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondVC") as! SecondVC
        secondVC.modalPresentationStyle = .overFullScreen
        secondVC.modalTransitionStyle = .flipHorizontal
        secondVC.firstVC = self
        self.present(secondVC, animated: true)
    }
    
    func pushSecondVC() {
        let secondVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondVC") as! SecondVC
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
}
