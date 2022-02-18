//
//  TodayInteractor.swift
//  wizz_animation
//
//  Created by Rachid Mahmoud on 26/10/2021.
//

import Foundation
import UIKit

protocol TodayBusinessLogic {
    func loadPhotos()
    func goDetailAction(username: String, photoAnimation: Photo, transitionDelegate: UIViewControllerTransitioningDelegate)
}

class TodayInteractor {
    private let presenter: TodayPresentationLogic
    private let router: TodayRoutingLogic
    private let worker: TodayWorker
    
    init(presenter: TodayPresentationLogic, router: TodayRoutingLogic, worker: TodayWorker) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
    }
}

extension TodayInteractor: TodayBusinessLogic {
    func goDetailAction(username: String, photoAnimation: Photo, transitionDelegate: UIViewControllerTransitioningDelegate) {
        router.navigateToDetail(username, photoAnimation: photoAnimation, transitionDelegate: transitionDelegate)
    }
    
    func loadPhotos() {
        worker.getPhotos { [weak self] result in
            switch result {
            case .success(let photos):
                self?.presenter.presentPhotos(photos)
            case let .failure(error, _):
                self?.presenter.presentError(error)
            }
        }
    }
}
