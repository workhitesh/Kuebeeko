//
//  RatingModel.swift
//  Kuebeeko
//
//  Created by Hitesh on 11/08/22.
//

import Foundation

struct RatingModel : Codable {
    let _id:String
    let reviewedById:String
    let reviewedByName:String
    let reviewedByImage:String?
    let tutorId:String
    let rating:Double
    let comment:String?
    let timestamp:Int64
}
