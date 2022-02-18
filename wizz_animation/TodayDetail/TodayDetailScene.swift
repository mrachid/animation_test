//
//  TodayDetailScene.swift
//  wizz_animation
//
//  Created by Rachid Mahmoud on 26/10/2021.
//

import Foundation
import UIKit

enum TodayDetailScene {
    case initTodayDetail(String, Photo)
    
    func configure() -> UIViewController? {
        switch self {
        case let .initTodayDetail(username, photoAnimation):
            return configureTodayDetail(username, photoAnimation: photoAnimation)
        }
    }
    
    private func configureTodayDetail(_ username: String, photoAnimation: Photo) -> UIViewController? {
        // Setup
        let viewController = TodayDetailViewController.storyboardInstance
        let interactor = TodayDetailInteractor(presenter: TodayDetailPresenter(viewController: viewController), worker: TodayDetailWorker(apiService: TodayDetailAPIService()))
        
        viewController?.interactor = interactor
        viewController?.username = username
        viewController?.photoAnimation = photoAnimation
        
        return viewController
    }
}
