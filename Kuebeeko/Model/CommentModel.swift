//
//  CommentModel.swift
//  Kuebeeko
//
//  Created by Hitesh on 15/08/22.
//

import Foundation

struct CommentModel : Codable {
    let _id:String
    let ratingId:String
    let commentedById:String
    let commentedByImage:String?
    let commentedByName:String?
    let comment:String
    let timestamp:Int64
}
