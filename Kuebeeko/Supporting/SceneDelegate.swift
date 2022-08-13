//
//  SceneDelegate.swift
//  Kuebeeko
//
//  Created by Hitesh on 06/08/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        NotificationCenter.default.addObserver(self, selector: #selector(setHomeVC(_:)), name: NSNotification.Name(rawValue: "SetHome"), object: nil)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .semibold), .foregroundColor: UIColor.white]
        UINavigationBar.appearance().barStyle = .blackOpaque
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        setHomeVC(nil)
    }

    @objc func setHomeVC(_ not:Notification?){
        if Utility.getUD(UserDefaultKeys.isLogin) as? Bool ?? false {
            if Utility.getUD(UserDefaultKeys.userType) as? Int == 0 {
                // go to admin home
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let tabBarController  = storyboard.instantiateViewController(withIdentifier: DashboardVC.identifier) as! DashboardVC
                let navBar = UINavigationController(rootViewController: tabBarController)
                navBar.isNavigationBarHidden = false
                // Make the Tab Bar Controller the root view controller
                window?.rootViewController = navBar
                window?.makeKeyAndVisible()
            } else if Utility.getUD(UserDefaultKeys.userType) as? Int == 1 {
                
                // tutor home
            } else {
                // student home
            }
        } else {
            // set login as home ( configured from storyboard )
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabBarController  = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            // Make the Tab Bar Controller the root view controller
            let nav = UINavigationController(rootViewController: tabBarController)
            window?.rootViewController = nav
            window?.makeKeyAndVisible()
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

