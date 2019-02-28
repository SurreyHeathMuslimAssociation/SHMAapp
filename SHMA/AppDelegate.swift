//
//  AppDelegate.swift
//  SHMA
//
//  Created by Umar Yaqub on 20/12/2018.
//  Copyright © 2018 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // configure firebase
        FirebaseApp.configure()
        // set window
        window = UIWindow(frame: UIScreen.main.bounds)
        if let user = Auth.auth().currentUser, user.isEmailVerified {
            window?.rootViewController = MemberTabBarController()
        } else {
            let initialNavController = UINavigationController(rootViewController: InitialController())
            window?.rootViewController = initialNavController//MemberTabBarController()//WelcomeController()
        }
        window?.makeKeyAndVisible()
        
        attemptRegisterForNotification(application)
        return true
    }
    
    private func attemptRegisterForNotification(_ application: UIApplication) {
        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
        // user notifcation auth
        // ios 10+ options
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: options) { (granted, err) in
                if let err = err {
                    print("Failed to request user notification auth", err.localizedDescription)
                    return
                }
                if granted {
                    print("Auth granted")
                } else {
                    print("Auth denied")
                }
        }
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Registered with fcm token: ", fcmToken)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
    }



}

