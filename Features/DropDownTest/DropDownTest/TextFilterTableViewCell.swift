//
//  TextFilterTableViewCell.swift
//  PatchNote_iOS
//
//  Created by JDeoks on 9/16/24.
//

import UIKit
import DropDown

class TextFilterTableViewCell: UITableViewCell {
    
    let dropDown = DropDown()
    
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var dataTextStackView: UIStackView!
    @IBOutlet var dataTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    private func initUI() {
        self.selectionStyle = .none
        // dataTextStackView
        dataTextStackView.layer.cornerRadius = 4
        
        // dataTextView
        dataTextView.text = "안녕하세요 텍스트"
        dataTextView.textContainerInset = .zero
        dataTextView.textContainer.lineFragmentPadding = 0
        dataTextView.delegate = self
        // 텍스트뷰의 스크롤을 비활성화하여 크기가 커지도록 설정
        dataTextView.isScrollEnabled = false
        
        // dropDown
        initDropDown()
        
        updateCellHeight()
    }
    
    /// 드롭다운의 기본 설정
    private func initDropDown() {
        /// 터치or 다른 이벤트에 dismiss되도록 설정
        dropDown.dismissMode = .automatic
        dropDown.cellHeight = 36
        // 앵커가 될 뷰 설정
        dropDown.anchorView = dataTextStackView
        // 앵커 기준으로 어디어 표시될지 결정
        dropDown.direction = .bottom
        // 드롭다운에서 선택된 값을 UITextView에 반영
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.dataTextView.text = item
            self?.updateCellHeight()
            // TODO: - 텍스트뷰의 데이터가 리스트에 있는지 확인 후 없으면 텍스트뷰 클리어
            self?.dataTextView.resignFirstResponder()
        }
    }
    
    /// 테이블뷰 셀 높이 재설정
    private func updateCellHeight() {
        print("\(type(of: self)) - \(#function)")

        updateTextViewHeight() // 텍스트뷰 내용이 변경될 때마다 높이 조정
        if let tableView = superview as? UITableView {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    // 드롭다운 업데이트 후 표시
    private func showDropDown() {
        updateDropDown()
        dropDown.show()
    }
    
    // 드롭다운의 오프셋, 데이터 재설정
    private func updateDropDown() {
        dropDown.width = dataTextStackView.frame.width
        // 드롭다운 옵션들. 여기서 검색결과 필터 리로드
        dropDown.dataSource = ["Option 1", "Option 2", "Option 3","Option 1","Option 1","Option 1", "Option 2", "Option 3","Option 1","Option 1", "Option 2", "Option 3","Option 1", ]
        dropDown.reloadAllComponents()
        // 텍스트뷰 크기가 가변적이라 크기가 업데이트 된 후에 오프셋 재설정이 필요
        self.dropDown.bottomOffset = CGPoint(x: 0, y: self.dataTextStackView.frame.height + 4)
    }
    

    
}

extension TextFilterTableViewCell: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard let tableView = superview as? UITableView else {
            print("테이블뷰 없음")
            return
        }
        guard let indexPath = tableView.indexPath(for: self) else {
            print("indexPath 없음")
            return
        }
        // 해당 셀이 테이블뷰의 제일 위로 오도록 스크롤
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)

        showDropDown()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        print("\(type(of: self)) - \(#function)")

        // 텍스트뷰의 내용이 변경될 때마다 셀의 높이를 업데이트
        updateCellHeight()
        // 변화한 셀의 크기를 기준으로 드롭다운의 오프셋 재설정
        updateDropDown()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        dropDown.hide()
    }
    
    /// 텍스트 뷰 높이 재설정
    private func updateTextViewHeight() {
        print("\(type(of: self)) - \(#function)")

        let size = CGSize(width: dataTextView.frame.width, height: .infinity)
        let estimatedSize = dataTextView.sizeThatFits(size)
        
        dataTextView.constraints.forEach { constraint in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
    
    
//    /// 스크롤 영역확보를 위해 푸터 일시적으로 추가
//    private func addFooterToTableView(_ tableView: UITableView) {
//        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 400))
//        footerView.backgroundColor = .clear
//        tableView.tableFooterView = footerView
//    }
//
//    /// 푸터 제거
//    private func removeFooterFromTableView(_ tableView: UITableView) {
//        tableView.tableFooterView = nil // 푸터 제거
//    }

    
}




//override func awakeFromNib() {
//    super.awakeFromNib()
//    setupTextView()
//    setupDropDown()
//}
//
//private func setupTextView() {
//    // UITextView에 포커스가 잡힐 때 드롭다운을 표시
//    textView.rx.didBeginEditing
//        .subscribe(onNext: { [weak self] in
//            self?.dropDown.show()
//        })
//        .disposed(by: disposeBag)
//}
//
//private func setupDropDown() {
//    dropDown.anchorView = textView // 드롭다운이 붙을 뷰 설정
//    dropDown.dataSource = ["Option 1", "Option 2", "Option 3"] // 드롭다운 옵션들
//    
//    // 드롭다운에서 선택된 값을 UITextView에 반영
//    dropDown.selectionAction = { [weak self] (index: Int, item: String) in
//        self?.textView.text = item
//    }
//}
