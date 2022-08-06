//
//  Constants.swift
//  CapstoneProject
//
//  Created by Hitesh on 03/12/21.
//

import UIKit

struct Messages {
    static let invalidEmailPassword = "Incorrect Credentials, the email or password is invalid"
    static let commonError = "Something went wrong, please try again later."
    
}

struct Colors {
    static let appTheme = UIColor(red: 47.0/255.0, green: 55.0/255.0, blue: 66.0/255.0, alpha: 1)
    static let bg = UIColor(red: 211.0/255.0, green: 214.0/255.0, blue: 209.0/255.0, alpha: 1)
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
