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
    
    var tutor:TutorModel! {
        didSet {
            lblName.text = tutor.name
            lblEmail.text = tutor.email
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