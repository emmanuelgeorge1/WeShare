//
//  PostCommentTableViewCell.swift
//  WeShare
//
//  Created by Emmanuel George on 08/09/22.
//

import UIKit

class PostCommentTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    static let identifier = "PostCommentTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "PostCommentTableViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
