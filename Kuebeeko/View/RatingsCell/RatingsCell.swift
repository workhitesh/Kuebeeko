//
//  RatingsCell.swift
//  Kuebeeko
//
//  Created by Hitesh on 11/08/22.
//

import UIKit

class RatingsCell: UITableViewCell {
    static let identifier = "RatingsCell"
    
    var rating:RatingModel! {
        didSet {
            lblRatedBy.text = rating.reviewedByName
            lblRateComment.text = rating.comment
            viewRating.rating = rating.rating
            viewRating.isUserInteractionEnabled = false
            imgProfile.loadImageWithIndicator(rating.reviewedByImage, placeholder: .profilePlaceholder)
        }
    }
    
    //MARK: IBOutlets
    @IBOutlet weak var imgProfile: DesignableImageView!
    @IBOutlet weak var lblRatedBy: UILabel!
    @IBOutlet weak var lblRateComment: UILabel!
    @IBOutlet weak var viewRating: CosmosView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
