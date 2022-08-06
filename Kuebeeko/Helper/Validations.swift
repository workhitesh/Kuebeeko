//
//  Validations.swift
//  CapstoneProject
//
//  Created by Hitesh on 03/12/21.
//

import UIKit

class Validations {
    
    class func isValidEmail(_ email:String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: email, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, email.count)) != nil
        } catch {
            return false
        }
    }
    
    class func isValidPassword(_ password:String) -> Bool {
        return password.count >= 6
    }
    
}
