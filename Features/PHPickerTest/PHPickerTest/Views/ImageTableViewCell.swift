//
//  ImageTableViewCell.swift
//  PHPickerTest
//
//  Created by JDeoks on 2/26/24.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    @IBOutlet var cellImageView: UIImageView!
    @IBOutlet var indexLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
