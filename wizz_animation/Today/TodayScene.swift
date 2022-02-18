//
//  TodayScene.swift
//  wizz_animation
//
//  Created by Rachid Mahmoud on 26/10/2021.
//

import Foundation
import UIKit

enum TodayScene {
    case initToday
    
    func configure() -> UIViewController? {
        switch self {
        case .initToday:
            return configureToday()
        }
    }
    
    private func configureToday() -> UIViewController? {
        // Setup
        let viewController = TodayViewController.storyboardInstance
        let interactor = TodayInteractor(presenter: TodayPresenter(viewController: viewController), router: TodayRouter(viewController: viewController), worker: TodayWorker(apiService: TodayAPIService()))
        
        viewController?.interactor = interactor
        
        return viewController
    }
}
