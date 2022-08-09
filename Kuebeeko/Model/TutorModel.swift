//
//  TutorModel.swift
//  Kuebeeko
//
//  Created by Hitesh on 09/08/22.
//

import Foundation

struct TutorModel : Codable {
    let id:String
    let name:String?
    let email:String?
    let phone:String?
    let image:String?
    let userType:UserType
}
