//
//  TutorModel.swift
//  Kuebeeko
//
//  Created by Hitesh on 09/08/22.
//

import Foundation

struct TutorModel : Codable {
    let _id:String
    let name:String?
    let email:String?
    let phone:Int64?
    let image:String?
    let userType:UserType
    let overallRating:Double? // out of 5 stars
    let subjectId:String?
    let bio:String?
    let hrlyRate:Double?
}
