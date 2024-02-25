//
//  UploadViewController.swift
//  PHPickerTest
//
//  Created by JDeoks on 2/26/24.
//

import UIKit
import PhotosUI

class UploadViewController: UIViewController {
    
    /// 선택된 결과를 저장하는 PHPickerResult 배열
    var selectedResults: [PHPickerResult] = []
    var selectedUIImages: [IndexedImage] = []
    
    @IBOutlet var imageTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        presentPicker()
    }
    
    func initUI() {
        imageTableView.dataSource = self
        imageTableView.delegate = self
        let imageTableViewCell = UINib(nibName: "ImageTableViewCell", bundle: nil)
        imageTableView.register(imageTableViewCell, forCellReuseIdentifier: "ImageTableViewCell")
    }

    @IBAction func closeButtonClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

// MARK: - PHPickerViewController
extension UploadViewController: PHPickerViewControllerDelegate {
    
    func presentPicker() {
        // PHPicker의 설정을 구성
        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        
        // 사용자 선택에 따라 필터 유형 설정
        configuration.filter = .images
        // 가능하다면, 변환을 피하기 위해 현재의 자산 표현 모드 설정
        configuration.preferredAssetRepresentationMode = .current
        // 사용자의 선택 순서를 존중하기 위해 선택 동작 설정
        configuration.selection = .ordered
        // 다중 선택을 가능하게 하기 위해 선택 제한 설정
        configuration.selectionLimit = 0

        // configuration
        if #available(iOS 17.0, *) {
//            configuration.mode = .compact
            configuration.disabledCapabilities = .ArrayLiteralElement(arrayLiteral: [.collectionNavigation, .search, .stagingArea,])
        } else {
            // Fallback on earlier versions
        }
        
        // 설정된 구성으로 PHPickerViewController 생성 및 표시
        let picker = PHPickerViewController(configuration: configuration)
        self.addChild(picker)
        picker.view.frame = view.frame
        // CGRect(x: 0, y: Int(self.view.frame.height / 2), width: Int(self.view.frame.width), height: Int(self.view.frame.height / 2))
        self.view.addSubview(picker.view)
        picker.didMove(toParent: self)
        picker.delegate = self
    }
    
    // 선택 완료 델리게이트
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        // results 이미 선택한 배열에 추가
        self.selectedResults += results
        if selectedResults.isEmpty {
            dismiss(animated: true)
        }
        
        let itemProviders = selectedResults.map { $0.itemProvider }

        for (index, selection) in self.selectedResults.enumerated() {
            let itemProvider = selection.itemProvider
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                DispatchQueue.main.async {
                    if let image = image as? UIImage {
                        self?.selectedUIImages.append(IndexedImage(index: index, image: image))
                        let indexPath = IndexPath(row: index, section: 0)
                        print("indexPath:", indexPath)
                        print("imageTableView", self?.imageTableView.numberOfRows(inSection: 0), "selectedResults.count", self?.selectedResults.count)
                        self?.imageTableView.reloadData()
                    }
                }
            }
        }
        
        // PHPickerViewController 닫기
        // PHPickerViewController 뷰를 뷰 계층에서 제거
        picker.view.removeFromSuperview()
        // PHPickerViewController가 부모 뷰 컨트롤러에서 제거될 것임을 알림
        picker.willMove(toParent: nil)
        // PHPickerViewController를 자식 뷰 컨트롤러 목록에서 제거
        picker.removeFromParent()
        // 부모 뷰 컨트롤러 변경 완료 알림
        picker.didMove(toParent: nil)
    }
    
}

extension UploadViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return selectedResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as? ImageTableViewCell else {
            return UITableViewCell() // 적절한 셀 타입이 아닐 경우 기본 셀 반환
        }

        // 선택된 이미지 배열에서 현재 indexPath.row에 해당하는 이미지 찾기
        if let indexedImage = selectedUIImages.first(where: { $0.index == indexPath.row }) {
            cell.cellImageView.image = indexedImage.image // 이미지 설정
        } else {
            cell.cellImageView.image = nil // 해당 인덱스의 이미지가 없는 경우, 이미지 뷰를 비움
        }

        return cell
    }
}
