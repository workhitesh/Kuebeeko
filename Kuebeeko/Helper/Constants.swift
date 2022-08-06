//
//  Constants.swift
//  CapstoneProject
//
//  Created by Hitesh on 03/12/21.
//

import UIKit

struct Messages {
    
}

//MARK:- Only prints items in debug mode
func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
    //        let formatter = DateFormatter()
    //        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS "
    //comment or no for non-private functions for print
    Swift.print(/*formatter.string(from: Date()),*/ "-- \n", items[0], separator:separator, terminator: terminator)
    #else
    //Swift.print(items[0], separator:separator, terminator: terminator)
    //Swift.print("Release mode")
    #endif
}

enum UserDefaultKeys {
    static let isLogin = "isLogin"
    static let userModel = "userModel"
    static let userEmail = "email"
    static let userId = "userId"
    static let userType = "userType"
}

let APPNAME = "Kuebeeko"
