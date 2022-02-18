//
//  HomeTabBarViewController.swift
//  wizz_animation
//
//  Created by Rachid Mahmoud on 26/10/2021.
//

import UIKit

class HomeTabBarViewController: UITabBarController {
    lazy public var initialTabBar: UIViewController = {
        guard let initialTabBar = TodayScene.initToday.configure() else {
            return UIViewController()
        }
        
        let title = "Today"
        let defaultImage = UIImage(named: "today")!
        let selectedImage = UIImage(named: "today")!
        let tabBarItems = (title: title, image: defaultImage, selectedImage: selectedImage)
        let tabBarItem = UITabBarItem(title: tabBarItems.title, image: tabBarItems.image, selectedImage: tabBarItems.selectedImage)
        
        initialTabBar.tabBarItem = tabBarItem
        
        return initialTabBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initTabBarItems()
    }
    
    private func initTabBarItems() {
        self.viewControllers = [initialTabBar]
    }
}
