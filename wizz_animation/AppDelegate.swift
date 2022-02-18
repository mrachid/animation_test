//
//  AppDelegate.swift
//  wizz_animation
//
//  Created by Rachid Mahmoud on 26/10/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = HomeTabBarViewController()
        let navigation = UINavigationController(rootViewController: viewController)
        
        window.rootViewController = navigation
        self.window = window
        window.makeKeyAndVisible()
        
        return true
    }
}

