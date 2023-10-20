//
//  ViewController.swift
//  UIImagePickerController
//
//  Created by 서정덕 on 2023/07/05.
//

import UIKit

// UIImagePickerController가 내부적으로 UINavigationController 포함하고 있음
// 델리게이트 설정을 하면 이미지 피커에서 취소&선택을 해도 화면이 내려가지 않음
// 띄워주고 있는 뷰컨에서 dismiss 해줘야 함
class ViewController: UIViewController {
    @IBOutlet var imageUIImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getImageBtnClicked(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
        // 뷰컨을 델리게이트로 설정
        picker.delegate = self
        self.present(picker, animated: false)
    }
}

// MARK:- 이미지 피커 컨트롤러 델리게이트 메소드
extension ViewController: UIImagePickerControllerDelegate {
    
    // 이미지 선택 후 호출
    // UIImagePickerController.InfoKey가 가지고 있는 enum이 딕셔너리의 키
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: false) {
            // .originalImage, .editedImage 선택
            let img = info[.originalImage] as? UIImage
            self.imageUIImageView.image = img
        }
    }
    
    // 이미지 피커 컨트롤러에서 취소 누르면 호출
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: false) {
            let alert = UIAlertController(title: "", message: "이미지 선택이 취소되었습니다", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            alert.addAction(cancel)
            self.present(alert, animated: false, completion: nil)
        }

    }
}

// MARK:- 네비게이션 컨트롤러 델리게이트 메소드
extension ViewController: UINavigationControllerDelegate {
    
}
