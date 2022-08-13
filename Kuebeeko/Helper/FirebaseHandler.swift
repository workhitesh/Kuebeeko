//
//  FirebaseHandler.swift
//  CapstoneProject
//
//  Created by Hitesh on 03/12/21.
//

import UIKit
import FirebaseAuth
import FirebaseStorage

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
    
    class func uploadImage(_ path:String, image:UIImage, result:@escaping (_ uploadedFileLink:String?) -> ()){
            // Create a root reference
            let storageRef = Storage.storage().reference()
            // Create storage reference
            let mountainsRef = storageRef.child("\(path)/\(Utility.currentTimestamp).jpg")
            // Create file metadata including the content type
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            guard let data = image.jpegData(compressionQuality: 0.7) else {
                result(nil)
                return
            }
            // Upload data and metadata
            mountainsRef.putData(data, metadata: metadata) { metadata, error in
                guard metadata != nil else {
                    // Uh-oh, an error occurred!
                    result(nil)
                    return
                }
                // You can also access to download URL after upload.
                mountainsRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        // Uh-oh, an error occurred!
                        result(nil)
                        return
                    }
                    result(downloadURL.absoluteString)
                }
            }
        }
    
}
