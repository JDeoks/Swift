//
//  UsersTableViewCell.swift
//  URLSessionTest
//
//  Created by JDeoks on 3/15/24.
//

import UIKit

class UsersTableViewCell: UITableViewCell {
    
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(user: UserModel) {
        idLabel.text = String(format: "%03d", user.id)
        nameLabel.text = user.name
    }
}
