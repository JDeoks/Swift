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
import RxKeyboard

class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    @IBOutlet var dataTableView: UITableView!
    @IBOutlet var keyboardBarStackView: UIStackView!
    @IBOutlet var hideKeyboardButton: UIButton!
    
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
        RxKeyboard.instance.visibleHeight
            .skip(1)
            .drive(onNext: { keyboardHeight in
                let isVisible = keyboardHeight > 0
                if isVisible {
                    self.keyboardBarStackView.snp.updateConstraints {
                        $0.bottom.equalToSuperview().offset(-keyboardHeight)
                    }
                    self.view.layoutIfNeeded()
                } else {
                    self.keyboardBarStackView.snp.updateConstraints {
                        $0.bottom.equalToSuperview().offset(48)
                    }
                    self.view.layoutIfNeeded()
                }
            })
            .disposed(by: disposeBag)
        
        hideKeyboardButton.rx.tap
            .subscribe { _ in
                self.view.endEditing(true)
            }
            .disposed(by: disposeBag)

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

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        100
    }
}
extension ViewController: UIScrollViewDelegate {
        
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrolledByUser {
            self.view.endEditing(true)
        } else {
            if let visibleCells = dataTableView.visibleCells as? [TextFilterTableViewCell] {
                for cell in visibleCells {
                    if cell.dataTextView.isFirstResponder {
                        cell.showDropDown()  // 드롭다운 위치를 업데이트
                    }
                }
            }
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrolledByUser = true
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrolledByUser = false
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
