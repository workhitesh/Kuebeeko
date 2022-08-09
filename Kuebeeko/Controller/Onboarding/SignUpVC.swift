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
        // Do any additional setup after loading the view.
    }
    
    
    
    // MARK:- Fxns
    fileprivate func setupUI(){
        self.navigationItem.title = "Sign Up"
    }
    
    
    fileprivate func createUser(_ email:String, password:String){
        Utility.showLoader()
        
        FirebaseHandler.createUserInAuth(email, password: password) { (user,err) in
            
            guard let user = user else {
                Utility.hideLoader()
                Utility.showAlert(with: err ?? Messages.commonError, on: self)
                return
            }
            
            Utility.showAlert(with: "User created successfully", on: self)
        }
        
    }
    
    
    // MARK:- IBActions
    @IBAction func signupPressed(_ sender:UIButton) {
        if Validations.isValidEmail(tfEmail.text ?? "") && Validations.isValidPassword(tfPwd.text ?? "") && Validations.isValidPassword(tfConfirmPwd.text ?? "") {
            if tfPwd.text == tfConfirmPwd.text {
                createUser(tfEmail.text ?? "", password: tfPwd.text ?? "")
            } else {
                Utility.showAlert(with: Messages.mismatchPwd, on: self)
            }
            
        } else {
            Utility.showAlert(with: Messages.invalidEmailPassword, on: self)
        }
    }
    


}
