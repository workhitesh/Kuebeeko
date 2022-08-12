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
        Utility.showLoader(on: self)
        
        FirebaseHandler.createUserInAuth(email, password: password) { (user,err) in
            
            guard user != nil else {
                Utility.showAlert(with: err ?? Messages.commonError, on: self)
                return
            }
            
            let params = ["userType":2,"email":email,"image":"","name":""] as [String : Any]
            Webservices.instance.post(url: API_BASE_URL+"student/create", params: params) { (success, resData , error) in
                Utility.hideLoader(from: self)

                if success {
                    Utility.showAlert(with: "Success\nPlease continue to sign in!", on: self)
                } else {
                    Utility.showAlert(with: error ?? Messages.commonError, on: self)
                }
            }
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
