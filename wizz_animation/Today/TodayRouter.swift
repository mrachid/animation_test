//
//  TodayRouter.swift
//  wizz_animation
//
//  Created by Rachid Mahmoud on 26/10/2021.
//

import UIKit

protocol TodayRoutingLogic {
    func navigateToDetail(_ username: String, photoAnimation: Photo, transitionDelegate: UIViewControllerTransitioningDelegate)
}

class TodayRouter {
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
}

extension TodayRouter: TodayRoutingLogic {
    
    // MARK: Navigation
    
    func navigateToDetail(_ username: String, photoAnimation: Photo, transitionDelegate: UIViewControllerTransitioningDelegate) {
        if let dtViewController = TodayDetailScene.initTodayDetail(username, photoAnimation).configure() {
            dtViewController.modalPresentationStyle = .fullScreen
            dtViewController.transitioningDelegate = transitionDelegate
            viewController?.navigationController?.present(dtViewController, animated: true)
        }
    }
}
