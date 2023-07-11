//
//  ChatMessageTableViewCell.swift
//  HW7.4
//
//  Created by 서정덕 on 2023/07/08.
//

import UIKit

class ChatMessageTableViewCell: UITableViewCell {
    @IBOutlet var chatMessageLabel: UILabel!
    
    var sender: Int?
    let ud = UserDefaults.standard
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        style()
    }

    func style() {
        chatMessageLabel.layer.cornerRadius = chatMessageLabel.frame.height / 2
        if sender == 1 {
            chatMessageLabel.backgroundColor = .white
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
