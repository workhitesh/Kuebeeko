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
    
    class func setAppNavBar(){
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .semibold), .foregroundColor: UIColor.white]
        UINavigationBar.appearance().barStyle = .blackOpaque
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    }
    
    class func setNavigationBar(_ controller:UIViewController, leftImage:UIImage?, rightImage:UIImage?, leftText:String = "", rightText:String = "" , title:String?){
        controller.navigationController?.isNavigationBarHidden = false
//        controller.navigationController?.navigationBar.topItem?.title = title
        controller.navigationItem.title = title
        controller.navigationController?.navigationBar.barTintColor = Colors.appTheme
        controller.navigationController?.navigationBar.tintColor = UIColor.white
        controller.navigationController?.navigationBar.isTranslucent = false
        
        var leftBarButton = UIBarButtonItem()
        if leftText != "" {
            leftBarButton = UIBarButtonItem(title: leftText, style: .plain, target: controller, action: Selector(("leftBarPressed:")))
        } else if leftImage != nil {
            leftBarButton = UIBarButtonItem(image: leftImage, style: .plain, target: controller, action: Selector(("leftBarPressed:")))
        }
        
        var rightBarButton = UIBarButtonItem()
        if rightText != "" {
            rightBarButton = UIBarButtonItem(title: rightText, style: .plain, target: controller, action: Selector(("rightBarPressed:")))
        } else if rightImage != nil {
            rightBarButton = UIBarButtonItem(image: rightImage, style: .plain, target: controller, action: Selector(("rightBarPressed:")))
        }

        controller.navigationItem.leftBarButtonItem = leftBarButton
        controller.navigationItem.rightBarButtonItem = rightBarButton

    }
    
    class func openEmailComposer(_ address:String){
        let appURL = URL(string: "mailto:\(address)")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(appURL)
        }
    }
    
    class func callNumber(_ number:String){
        guard let number = URL(string: "tel://" + number) else { return }
        UIApplication.shared.open(number, options: [:], completionHandler: nil)
    }
}
