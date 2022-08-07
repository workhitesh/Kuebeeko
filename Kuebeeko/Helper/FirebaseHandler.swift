//
//  FirebaseHandler.swift
//  CapstoneProject
//
//  Created by Hitesh on 03/12/21.
//

import UIKit
import FirebaseAuth

class FirebaseHandler {
    typealias ResponseBlock = (_ success:Bool, _ err:String?) -> Void
    
    // MARK:- Auth with firebase
    class func authenticateUser(_ email:String, password:String , result:@escaping(_ user:User?, _ err:String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { res, err in
            guard let user = res?.user else {
                result(nil, err?.localizedDescription)
                return
            }
            result(user,nil)
        }
    }
    
    class func createUserInAuth(_ email:String, password:String, result:@escaping(_ user:User?, _ err:String?) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { res, err in
            guard let user = res?.user else {
                result(nil, err?.localizedDescription)
                return
            }
            result(user,nil)
        }
    }
    
    class func resetPassword(_ email:String , result:@escaping ResponseBlock) {
        Auth.auth().sendPasswordReset(withEmail: email) { err in
            result(err == nil, err?.localizedDescription)
        }
    }
    
}
