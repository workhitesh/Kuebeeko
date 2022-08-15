//
//  CommentCell.swift
//  Kuebeeko
//
//  Created by Hitesh on 15/08/22.
//

import UIKit

class CommentCell: UITableViewCell {
    static let identifier = "CommentCell"
    
    //MARK: IBOutlets
    @IBOutlet weak var imgCommenter: DesignableImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    
    var comment:CommentModel! {
        didSet {
            imgCommenter.loadImageWithIndicator(comment.commentedByImage, placeholder: .profilePlaceholder)
            lblName.text = comment.commentedByName
            lblComment.text = comment.comment
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
