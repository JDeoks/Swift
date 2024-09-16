//
//  ViewController.swift
//  DropDownTest
//
//  Created by JDeoks on 9/16/24.
//

import UIKit
import RxSwift
import SnapKit
import DropDown

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
//        
//        let dropDown = DropDown()
//
//        // The view to which the drop down will appear on
//        dropDown.anchorView = view // UIView or UIBarButtonItem
//
//        // The list of items to display. Can be changed dynamically
//        dropDown.dataSource = ["Car", "Motorcycle", "Truck"]
//
//        /*** IMPORTANT PART FOR CUSTOM CELLS ***/
//        dropDown.cellNib = UINib(nibName: "MyCell", bundle: nil)
//
//        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
//           guard let cell = cell as? DropDownCell else { return }
//
//           // Setup your custom UI components
////           cell.logoImageView.image = UIImage(named: "logo_\(index)")
//        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
//
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        200
//    }
}
extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
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
