//
//  Extension+UIImageView.swift
//  Kuebeeko
//
//  Created by Hitesh on 12/08/22.
//

import UIKit
import SDWebImage

extension UIImageView {
    func loadImageWithIndicator(_ url:String?, placeholder:UIImage) {
        if let u = url {
            self.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.sd_setImage(with: URL(string: u), placeholderImage: placeholder)
        } else {
            self.image = UIImage()
        }
    }
}

extension UIImage {
    static let profilePlaceholder = UIImage(named: "add-photo")!
}
