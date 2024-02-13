//
//  FriendsTableViewCell.swift
//  Chat
//
//  Created by JDeoks on 12/9/23.
//

import UIKit
import Kingfisher

class UsersTableViewCell: UITableViewCell {
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(profileImageURL: String, name: String ) {
        let url = URL(string: profileImageURL)
        profileImageView.kf.setImage(with: url)
        nameLabel.text = name
    }
    
    func setData(userModel: UserModel) {
        if let url = userModel.profileImageURL {
            profileImageView.kf.setImage(with: url)
        }
        nameLabel.text = userModel.name
    }
    
    
}
