//
//  ViewController.swift
//  DropDownTest
//
//  Created by JDeoks on 9/16/24.
//

import UIKit
import RxSwift
import SnapKit

class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    @IBOutlet var dataTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        action()
    }
    
    private func initUI() {
        dataTableView.separatorStyle = .none
        dataTableView.dataSource = self
        dataTableView.delegate = self
        dataTableView.registerCell(ofType: TextFilterTableViewCell.self)
    }
    
    private func action() {
//        closeButton.rx.tap
//            .subscribe { _ in
//                self.dismiss(animated: true)
//            }
//            .disposed(by: disposeBag)
//        
//        hideKeyboardButton.rx.tap
//            .subscribe { _ in
//                self.view.endEditing(true)
//            }
//            .disposed(by: disposeBag)
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dataTableView.dequeueReusableCell(withIdentifier: String(describing: TextFilterTableViewCell.self), for: indexPath) as! TextFilterTableViewCell
        return cell
    }
//
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        200
//    }
}


extension UITableView {
    
    /// UITableViewCell을 nib 파일로 등록.
    /// ```
    /// tableView.registerCell(ofType: CustomTableViewCell.self)
    /// ```
    func registerCell<T: UITableViewCell>(ofType type: T.Type) {
        let identifier = String(describing: type)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: identifier)
    }
    
}
