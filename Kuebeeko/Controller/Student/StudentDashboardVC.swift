//
//  StudentDashboardVC.swift
//  Kuebeeko
//
//  Created by Hitesh on 13/08/22.
//

import UIKit

class StudentDashboardVC: UIViewController {
    static let identifier = "StudentDashboardVC"

    //MARK: View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    //MARK: Fxns
    fileprivate func setupUI(){
        Utility.setNavigationBar(self, leftImage: nil, rightImage: UIImage(named: "logout-icon"), title: "Dashboard")
    }
    
    
    //MARK:IBActions
    @IBAction func rightBarPressed(_ sender:UIBarButtonItem){
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
    

}
