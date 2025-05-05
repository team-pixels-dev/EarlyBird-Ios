//
//  Appdelegate.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/18/25.
//
import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

//
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      FirebaseApp.configure()
      return true
    }
}
