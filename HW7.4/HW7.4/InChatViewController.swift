//
//  InChatViewController.swift
//  HW7.4
//
//  Created by 서정덕 on 2023/07/07.
//

import UIKit

class InChatViewController: UIViewController {

    @IBOutlet var chatPartnerNameLabel: UILabel!
    @IBOutlet var messageTextField: UITextField!
    
    var paramChatPartnerName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiInit()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonCliked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func uiInit() {
        chatPartnerNameLabel.text = paramChatPartnerName
        messageTextField.layer.cornerRadius = messageTextField.frame.height / 2
        messageTextField.clipsToBounds = true

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
