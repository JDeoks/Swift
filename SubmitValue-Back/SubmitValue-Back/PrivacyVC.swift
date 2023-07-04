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
//        updateByParam()
//        updateByAppDel()
        updateByUD()
    }
    
    @IBAction func editPrivacy(_ sender: Any) {
        guard let editVC = self.storyboard?.instantiateViewController(identifier: "PrivacyEditVC") as? PrivacyEditVC else {
            return
        }
        self.navigationController?.pushViewController(editVC, animated: true)
    }
    
    /// 직접전달 사용
    func updateByParam() {
        emailText.text = paramEmail
        autoUpdateText.text = paramMode ? "갱신함": "갱신하지 않음"
        intervalText.text = "\(Int(paramInterval))분 마다"
    }
    
    /// 엡 델리게이트 사용
    func updateByAppDel() {
        // 앱 델리게이트 인스턴스 가져옴
        let appDel = UIApplication.shared.delegate as! AppDelegate
        emailText.text = appDel.paramEmail
        autoUpdateText.text = appDel.paramMode ? "갱신함": "갱신하지 않음"
        intervalText.text = "\(Int(appDel.paramInterval))분 마다"
    }
    
    /// 유저 디폴트 사용
    func updateByUD() {
        let ud = UserDefaults.standard
        emailText.text = ud.value(forKey: "email") as? String
        autoUpdateText.text = ud.bool(forKey: "mode") ? "갱신함": "갱신하지 않음"
        intervalText.text = "\(Int(ud.double(forKey: "interval")))분 마다"
    }
}
