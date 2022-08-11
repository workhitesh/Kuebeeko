//
//  UserModel.swift
//  Kuebeeko
//
//  Created by Hitesh on 09/08/22.
//

import Foundation

struct UserModel : Codable {
    let id:String
    let userType:UserType // 0 = admin, 1 = tutor, 2 = student
    let email:String
    let image:String?
}

enum UserType : Int, Codable {
    case admin   = 0
    case tutor   = 1
    case student = 2
}
