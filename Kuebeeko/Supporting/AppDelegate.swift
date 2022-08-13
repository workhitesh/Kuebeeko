//
//  AppDelegate.swift
//  Kuebeeko
//
//  Created by Hitesh on 06/08/22.
//

import UIKit
import CoreData
import Firebase
//import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
        let window = UIWindow(frame: UIScreen.main.bounds)
        Utility.setAppNavBar()
        self.window = window
        setHomeVC()
        getAllSubjects()
        return true
    }
    
    func setHomeVC(){
        if Utility.getUD(UserDefaultKeys.isLogin) as? Bool ?? false {
            if Utility.getUD(UserDefaultKeys.userType) as? Int == 0 {
                // go to admin home
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let tabBarController  = storyboard.instantiateViewController(withIdentifier: DashboardVC.identifier) as! DashboardVC
                // Make the Tab Bar Controller the root view controller
                let appDel = UIApplication.shared.delegate as! AppDelegate
                appDel.window?.rootViewController = tabBarController
                appDel.window?.makeKeyAndVisible()
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
            let appDel = UIApplication.shared.delegate as! AppDelegate
            let nav = UINavigationController(rootViewController: tabBarController)
            appDel.window?.rootViewController = nav
            appDel.window?.makeKeyAndVisible()
        }
    }

    
    func getAllSubjects(){
        Webservices.instance.get(url: API_BASE_URL+"subjects", params: nil) { success, response, error in
            if success {
                arrSubjects.removeAll()
                if let subjects = response as? NSArray {
                    for i in 0..<subjects.count {
                        if let sub = subjects[i] as? NSDictionary {
                            let objSub = SubjectModel(_id: sub["_id"] as? String ?? "", name: sub["name"] as? String ?? "")
                            arrSubjects.append(objSub)
                        }
                    }
                }
            }
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Kuebeeko")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

