//
//  SignUpVC.swift
//  CapstoneProject
//
//  Created by Hitesh on 03/12/21.
//

import UIKit

class SignUpVC: UIViewController {
    static let identifier = "SignUpVC"
    
    // MARK:- IBOutlets
    @IBOutlet weak var tfEmail:UITextField!
    @IBOutlet weak var tfPwd:UITextField!
    @IBOutlet weak var tfConfirmPwd:UITextField!

    // MARK:- View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
//        self.navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
    }
    
    
    
    // MARK:- Fxns
    fileprivate func setupUI(){
        
    }
    
    
    fileprivate func createUser(_ email:String, password:String){
        Utility.showLoader()
        /*
        FirebaseHandler.createUserInAuth(email, password: password) { user in
            
            guard let user = user else {
                Utility.hideLoader()
                Utility.showAlert(with: Messages.commonErrorMessage, on: self)
                return
            }
            
            let userM = UserModel(id: user.uid, email: email, firstName: "", lastName: "", gender: nil, profilePicture: "", userType: .user, favProperties: nil)
            FirebaseHandler.setDocument(path: "/users/\(user.uid)", object: userM) { error in
                Utility.hideLoader()
                if let err = error {
                    print(err)
                } else {
                    print("created user")
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SetHome"), object: nil)
                }
            }
        }
        */
    }
    
    
    // MARK:- IBActions
    @IBAction func signupPressed(_ sender:UIButton) {
        if Validations.isValidEmail(tfEmail.text ?? "") && Validations.isValidPassword(tfPwd.text ?? "") && Validations.isValidPassword(tfConfirmPwd.text ?? "") {
            if tfPwd.text == tfConfirmPwd.text {
                createUser(tfEmail.text ?? "", password: tfPwd.text ?? "")
            } else {
//                Utility.showAlert(with: Messages.commonErrorMessage, on: self)
            }
            
        } else {
            Utility.showAlert(with: Messages.invalidEmailPassword, on: self)
        }
    }
    


}
