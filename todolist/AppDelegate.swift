//
//  AppDelegate.swift
//  todolist
//
//  Created by Mac on 06/09/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import Firebase
import OneSignal
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        setupThirdPartyServices(launchOptions: launchOptions)
        setupPushNotification(application: application, launchOptions: launchOptions)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = UINavigationController(rootViewController: ViewController())
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

extension AppDelegate {
    
    //MARK:- Setup Third Party Services
    final private func setupThirdPartyServices(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        
        //MARK:- Firebase
        FirebaseApp.configure()
        
    }
    
    final private func setupPushNotification(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        
        //MARK:- OneSignal
         let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false]
        
         OneSignal.initWithLaunchOptions(launchOptions,
         appId: "4db007ad-696b-4bca-a348-ef8d2e59834b",
         handleNotificationAction: nil,
         settings: onesignalInitSettings)

         OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification;

        
         OneSignal.promptForPushNotifications(userResponse: { accepted in
         print("User accepted notifications: \(accepted)")
         })
    }
}
