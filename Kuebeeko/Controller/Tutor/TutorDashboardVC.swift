//
//  TutorDashboardVC.swift
//  Kuebeeko
//
//  Created by Hitesh on 13/08/22.
//

import UIKit

class TutorDashboardVC: UIViewController {
    static let identifier = "TutorDashboardVC"
    fileprivate var optionsArr = [String]()
    var userType:Int {
        return Utility.getUD(UserDefaultKeys.userType) as? Int ?? 2
    }
    
    //MARK:IBOutlets
    @IBOutlet private weak var tblView:UITableView!

    //MARK: View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    //MARK: Fxns
    fileprivate func setupUI(){
        Utility.setNavigationBar(self, leftImage: nil, rightImage: nil, title: "Dashboard")
        if let userType = Utility.getUD(UserDefaultKeys.userType) as? Int, userType == 1 {
            // tutor
            optionsArr.append("My Reviews")
            optionsArr.append("Edit Profile")
        } else {
            
        }
        optionsArr.append("Logout")
    }

}

extension TutorDashboardVC:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            cell?.selectionStyle = .none
            cell?.textLabel?.text = "   \(optionsArr[indexPath.row])"
            cell?.accessoryType = .disclosureIndicator
            return cell ?? UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.textLabel?.text = "   \(optionsArr[indexPath.row])"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if userType == 1 {
            if indexPath.row == 0 {
                
            } else if indexPath.row == 1 {
                Utility.showLoader(on: self)
                let email = Utility.getUD(UserDefaultKeys.userEmail) as? String ?? ""
                Webservices.instance.get(url: API_BASE_URL+"tutor/\(email)", params: nil) { success, response, error in
                    Utility.hideLoader(from: self)
                    if success {
                        guard let dict = (response as? NSArray)?[0] as? NSDictionary else {
                            return
                        }
                        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: AddTutorVC.identifier) as? AddTutorVC else {
                            return
                        }
                        let tutor = TutorModel(_id: dict["_id"] as? String ?? "", name: dict["name"] as? String ?? "", email: dict["email"] as? String ?? "", phone: dict["phone"] as? Int64 ?? 0, image: dict["image"] as? String ?? "", userType: .tutor, overallRating: dict["overallRating"] as? Double ?? 0.0, subjectId: dict["subjectId"] as? String ?? "", bio: dict["bio"] as? String ?? "", hrlyRate: dict["hrlyRate"] as? Double ?? 0.0)
                        vc.tutor = tutor
                        self.navigationController?.pushViewController(vc, animated: true)
                    } else {
                        Utility.showAlert(with: Messages.userNotFound, on: self)
                    }
                }
            } else {
                let logAlert = UIAlertController(title: APPNAME, message: Messages.logoutConfirmation, preferredStyle: .alert)
                let logout = UIAlertAction(title: "Logout", style: .destructive) { logA in
                    Utility.removeUD(UserDefaultKeys.isLogin)
                    guard let appDel = UIApplication.shared.delegate as? AppDelegate else {
                        return
                    }
                    appDel.setHomeVC()
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SetHome"), object: nil)
                }
                logAlert.addAction(logout)
                let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                logAlert.addAction(cancel)
                present(logAlert, animated: true, completion: nil)
            }
        } else {
            
        }
    }
    
    
}
