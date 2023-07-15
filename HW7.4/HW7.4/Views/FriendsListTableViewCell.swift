//
//  FriendsListTableViewCell.swift
//  HW7.4
//
//  Created by 서정덕 on 2023/07/14.
//

import UIKit

class FriendsListTableViewCell: UITableViewCell {
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var profileMessageLabel: UILabel!
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initUI() {
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
    }

}
