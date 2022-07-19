//
//  AppDelegate.swift
//  AudioRecorder
//
//  Created by Ibrahim Mo Gedami on 7/19/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let vc = AudioRecorderViewController()
        let nav = UINavigationController(rootViewController: vc)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }

}

