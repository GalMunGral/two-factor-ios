//
//  AppDelegate.swift
//  Two Factor
//
//  Created by Wenqi He on 12/24/18.
//  Copyright © 2018 Wenqi He. All rights reserved.
//

import UIKit
import Foundation
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var deviceToken: String? // Testing

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    let center = UNUserNotificationCenter.current()
    center.requestAuthorization(options: [.alert]) { (granted, err) in
      if let err = err { print(err.localizedDescription) }
      if granted { print("Authorization granted for alerts") }
    } // IMPORTANT: must be authorized for alert to display.
    
    UIApplication.shared.registerForRemoteNotifications() // Request devide token
    
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }

  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    self.deviceToken = deviceToken.hexEncodedString()
    print("From AppDelegate: Registration success!")
//    do {
//      let url = URL(string: "http://128.61.31.37:3000/test")!
//      let json = try JSONSerialization.data(withJSONObject: [ "token": deviceToken.hexEncodedString()], options: [])
//      var request = URLRequest(url: url)
//      request.httpMethod = "POST"
//      request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//      request.httpBody = json
//      let task = URLSession.shared.dataTask(with: request)
//      task.resume()
//    } catch {
//      // Error handling
//    }
  }
  
  func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    print("From AppDelegate: Registration for remote notification failed!")
  }
  
  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    print("Received remote notification!")
  }

}

extension Data {
  func hexEncodedString() -> String {
    return map { String(format: "%02hhx", $0) }.joined()
  }
}

