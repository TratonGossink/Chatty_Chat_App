//
//  AppDelegate.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 7/31/23.
//


import Foundation
import UIKit
import FirebaseCore

class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions:
                   [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
