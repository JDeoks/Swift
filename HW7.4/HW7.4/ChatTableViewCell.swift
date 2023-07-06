//
//  ChatTableViewCell.swift
//  HW7.4
//
//  Created by 서정덕 on 2023/07/07.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var messagePreviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("ChatTableViewCell-awakeFromNib-")
        self.profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
