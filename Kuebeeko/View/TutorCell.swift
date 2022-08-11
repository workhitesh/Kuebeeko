//
//  TutorCell.swift
//  Kuebeeko
//
//  Created by Hitesh on 09/08/22.
//

import UIKit

class TutorCell: UITableViewCell {
    static let identifier = "TutorCell"

    @IBOutlet weak var imgProfile: DesignableImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var viewRating:CosmosView!
    
    var tutor:TutorModel! {
        didSet {
            lblName.text = tutor.name
            lblEmail.text = tutor.email
            viewRating.rating = tutor.overallRating ?? 0.0
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
