//
//  ResetPasswordVC.swift
//  CapstoneProject
//
//  Created by Hitesh on 05/12/21.
//

import UIKit

class ResetPasswordVC: UIViewController {
    static let identifier = "ResetPasswordVC"
    
    // MARK:- IBOutlets
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfConfirmEmail: UITextField!
    
    
    // MARK:- View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    // MARK:- Fxns
    fileprivate func setupUI(){
        self.navigationItem.title = "Reset Password"
    }
    
    fileprivate func resetPassword(_ email:String) {
        Utility.showLoader()
        FirebaseHandler.resetPassword(email) { (success, err) in
            Utility.hideLoader()
            if success {
                Utility.showAlert(with: "Instructions sent on \(email)", on: self)
            } else {
                Utility.showAlert(with: err ?? Messages.commonError, on: self)
            }
        }
    }
    
    // MARK:- IBActions
    @IBAction func confirmPressed(_ sender: UIButton) {
        if Validations.isValidEmail(tfEmail.text ?? "") && Validations.isValidEmail(tfConfirmEmail.text ?? "") {
            if tfEmail.text == tfConfirmEmail.text {
                // reset password
                resetPassword(tfEmail.text ?? "")
            } else {
                Utility.showAlert(with: Messages.mismatchEmail, on: self)
            }
        } else {
            Utility.showAlert(with: Messages.invalidEmail, on: self)
        }
    }
    
}
