//
//  ViewController.swift
//  Two Factor
//
//  Created by Wenqi He on 12/24/18.
//  Copyright © 2018 Wenqi He. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController,
  UITextFieldDelegate, UNUserNotificationCenterDelegate {

  @IBOutlet weak var serverIPTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    UNUserNotificationCenter.current().delegate = self
    serverIPTextField.delegate = self
    serverIPTextField.enablesReturnKeyAutomatically = true
  }

  func textFieldDidEndEditing(_ textField: UITextField) {
    let deviceToken: String = (UIApplication.shared.delegate as! AppDelegate).deviceToken!
    do {
      let url = URL(string: "http://\(textField.text ?? ""):3000/ios/device-token")!
      let json = try JSONSerialization.data(withJSONObject: [ "token": deviceToken ], options: [])
      var request = URLRequest(url: url)
      request.httpMethod = "POST"
      request.addValue("application/json", forHTTPHeaderField: "Content-Type")
      request.httpBody = json
      let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
        if err != nil { print(String(describing: err)) }
        if let data = data { self.handleJsonData(data) }
      }
      task.resume()
    } catch {
      print(error)
    }
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    print("Will present notification: \(notification.request.content.title)")
//    completionHandler(UNNotificationPresentationOptions.alert) // Display the alert anyways
  }
  
  private func handleJsonData(_ data: Data) {
    do {
      let json = try JSONSerialization.jsonObject(with: data, options: [])
      print(String(describing: json))
    } catch {
      print("Error: \(error)")
    }
  }

}

