//
//  WhatsAppCloneAppSwiftUIApp.swift
//  WhatsAppCloneAppSwiftUI
//
//  Created by Alican TARIM on 4.05.2024.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct WhatsAppCloneAppSwiftUIApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate


  var body: some Scene {
    WindowGroup {
        RootScreen()
    }
  }
}
