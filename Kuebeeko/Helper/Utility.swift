//
//  Utility.swift
//  CapstoneProject
//
//  Created by Hitesh on 03/12/21.
//

import UIKit

class Utility {
    
    static var appDel = UIApplication.shared.delegate as! AppDelegate
    
    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
            
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)
            
        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
    
    class func showAlert(with message:String, on controller:UIViewController) {
        let alertVC = UIAlertController(title: APPNAME, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alertVC.addAction(ok)
        controller.present(alertVC, animated: true, completion: nil)
    }
    
    class func showLoader(){
//        SVProgressHUD.show()
    }
    
    class func hideLoader(){
//        SVProgressHUD.dismiss()
    }
    
    class func saveUD(_ value:Any?, key:String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func getUD(_ key:String) -> Any?{
        return UserDefaults.standard.value(forKey: key)
    }
    
    class func removeUD(_ key:String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func dateToString(date:Date, format:String) -> String {
        let formatter3 = DateFormatter()
        formatter3.dateFormat = format
        return formatter3.string(from: date)
    }
    
    class var currentTimestamp: Int {
        return Int(Date().timeIntervalSince1970 * 1000)
    }
}
