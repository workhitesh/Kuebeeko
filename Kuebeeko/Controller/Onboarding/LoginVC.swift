//
//  LoginVC.swift
//  Kuebeeko
//
//  Created by Hitesh on 06/08/22.
//

import UIKit

class LoginVC: UIViewController {
    static let identifier = "LoginVC"
    
    //MARK: IBOutlets
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPwd: UITextField!
    
    //MARK: View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    //MARK: Fxns
    fileprivate func setupUI(){
        Utility.setNavigationBar(self, leftImage: nil, rightImage: nil, title: "Login")
    }
    
    
    //MARK: IBActions
    @IBAction func loginPressed(_ sender: UIButton) {
        // do validations
        if Validations.isValidEmail(tfEmail.text ?? "") && Validations.isValidPassword(tfPwd.text ?? "") {
            // firebase auth call
            FirebaseHandler.authenticateUser(tfEmail.text ?? "", password: tfPwd.text ?? "") { (user, err) in
                if let user = user {
                    // successfull validation
                    print("successfull validation : \(user)")
                    
                    // check if user exists in db
                    Webservices.instance.get(url: API_BASE_URL+"student/\(self.tfEmail.text ?? "")", params: nil) { success, response, error in
                        if success {
                            guard let dict = (response as? NSArray)?[0] as? NSDictionary else {
                                return
                            }
                            Utility.saveUD(true, key: UserDefaultKeys.isLogin)
                            Utility.saveUD(dict["userType"] as? Int ?? 2, key: UserDefaultKeys.userType)
                            Utility.saveUD(user.email ?? "", key: UserDefaultKeys.userEmail)
                            Utility.saveUD(dict["_id"] as? String ?? "", key: UserDefaultKeys.userId)
                            
                            print("user auth success and found in db, go to its home")
                            guard let appDel = UIApplication.shared.delegate as? AppDelegate else {
                                return
                            }
                            appDel.setHomeVC()
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SetHome"), object: nil)
                        } else {
                            Utility.showAlert(with: Messages.userNotFound, on: self)
                        }
                    }
                    
                } else {
                    Utility.showAlert(with: err ?? Messages.commonError, on: self)
                }
            }
        } else {
            Utility.showAlert(with: Messages.invalidEmailPassword, on: self)
        }
    }
    
    @IBAction func loginAsAdminPressed(_ sender: UIButton) {
        // do validations
        if Validations.isValidEmail(tfEmail.text ?? "") && Validations.isValidPassword(tfPwd.text ?? "") {
            // firebase auth call
            FirebaseHandler.authenticateUser(tfEmail.text ?? "", password: tfPwd.text ?? "") { (user,err) in
                if let user = user {
                    // successfull validation
                    print("successfull validation : \(user)")
                    
                    // check if admin
                    if Admins.contains(user.email ?? "") {
                        Utility.saveUD(true, key: UserDefaultKeys.isLogin)
                        Utility.saveUD(0, key: UserDefaultKeys.userType)
                        Utility.saveUD(user.email ?? "", key: UserDefaultKeys.userEmail)
                        
                        guard let appDel = UIApplication.shared.delegate as? AppDelegate else {
                            return
                        }
                        appDel.setHomeVC()
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SetHome"), object: nil)
                        
//                        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: DashboardVC.identifier) as? DashboardVC else {
//                            return
//                        }
//                        self.navigationController?.pushViewController(vc, animated: true)
                    } else {
                        Utility.showAlert(with: Messages.notAdmin, on: self)
                    }
                    
                } else {
                    Utility.showAlert(with: err ?? Messages.commonError, on: self)
                }
            }
        } else {
            Utility.showAlert(with: Messages.invalidEmailPassword, on: self)
        }
    }
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: SignUpVC.identifier) as? SignUpVC else {
            return
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func forgotPwdPressed(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: ResetPasswordVC.identifier) as? ResetPasswordVC else {
            return
        }
        navigationController?.pushViewController(vc, animated: true)
    }

}
