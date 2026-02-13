//
//  AppDelegate.swift
//  MVVM Practice (Movie app)
//
//  Created by Mustafa Nour on 16/02/2025.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Request notification permissions
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            } else {
                print("Notification permission denied: \(error?.localizedDescription ?? "No error")")
            }
        }
        
        // Set animated launch screen as initial root
        window = UIWindow(frame: UIScreen.main.bounds)
        let launchVC = LaunchScreenViewController()
        window?.rootViewController = launchVC
        window?.makeKeyAndVisible()
        
        return true
    }
    
    // MARK: -  notification Things
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        scheduleNotification()
    }
    func scheduleNotification() {
        
        let content = UNMutableNotificationContent()
        content.title = "Hurry up "
        content.body = "give a look to top Rated Movies"
        content.sound = UNNotificationSound.default
        
        // Trigger the notification after 5 seconds
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: "backgroundNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
    
}
