//
//  PostTableViewCell.swift
//  URLSessionTest
//
//  Created by JDeoks on 3/14/24.
//

import UIKit

class PostsTableViewCell: UITableViewCell {
    
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(post: PostModel) {
        idLabel.text = String(format: "%03d", post.id)
        titleLabel.text = post.title
    }
    
}
