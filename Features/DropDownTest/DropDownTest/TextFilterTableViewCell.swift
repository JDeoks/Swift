//
//  TextFilterTableViewCell.swift
//  PatchNote_iOS
//
//  Created by JDeoks on 9/16/24.
//

import UIKit

class TextFilterTableViewCell: UITableViewCell {
    
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var dataTextStackView: UIStackView!
    @IBOutlet var dataTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    private func initUI() {
        print("\(type(of: self)) - \(#function)")
        // dataTextStackView
        dataTextStackView.layer.cornerRadius = 4

        // dataTextView
        dataTextView.text = "안녕하세요 텍스트뷰예텍스트뷰예텍스트뷰예텍스트뷰예"
        dataTextView.textContainerInset = .zero
        dataTextView.textContainer.lineFragmentPadding = 0
        dataTextView.delegate = self
        dataTextView.isScrollEnabled = false // 텍스트뷰의 스크롤을 비활성화하여 크기가 커지도록 설정
        
        updateCellHeight()
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
    
}

extension TextFilterTableViewCell: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        print("\(type(of: self)) - \(#function)")

        // 텍스트뷰의 내용이 변경될 때마다 셀의 높이를 업데이트
        updateCellHeight()
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
    
}
