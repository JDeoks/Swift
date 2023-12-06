//
//  ViewController.swift
//  Chat
//
//  Created by 서정덕 on 12/5/23.
//

import UIKit
import SwiftUI
import SnapKit
import Firebase
import FirebaseRemoteConfig

class ViewController: UIViewController {
    
    var remoteConfig: RemoteConfig!
    
    var box = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        setRemoteConfig()
    }
    
    func initUI() {
        //view
        view.backgroundColor = UIColor(hex: "dfadfa")
        // box
        self.view.addSubview(box)
        box.image = UIImage(named: "firebase_28dp.png")
        box.snp.makeConstraints { make in
            make.center.equalTo(self.view)
        }
    }
    
    func setRemoteConfig() {
        remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        // 앱 켤때마다 실행
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        // 기본 설정
        remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")
        fetchRemoteConfig()
    }
    
    /// 원격 구성 받아오기
    func fetchRemoteConfig() {
        remoteConfig.fetch { (status, error) -> Void in
          if status == .success {
            print("Config fetched!")
            // 패치한 원격구성 적용
            self.remoteConfig.activate(completion: nil)
          } else {
            print("Config not fetched")
            print("Error: \(error?.localizedDescription ?? "No error available.")")
          }
          self.displayWelcome()
        }
    }
    
    func displayWelcome() {
        let color = remoteConfig["splash_background"].stringValue
        let caps = remoteConfig["splash_message_caps"].boolValue
        let message = remoteConfig["splash_message"].stringValue
        if caps {
            let alert = UIAlertController(title: "공지사항", message: message, preferredStyle: .alert)
            let okey = UIAlertAction(title: "확인", style: .default) { action in
                exit(0)
            }
            alert.addAction(okey)
            present(alert, animated: true)
        }
        self.view.backgroundColor = UIColor(hex: color! )
    }

}

#Preview {
    let vc = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "ViewController") as! ViewController
    return vc
}
