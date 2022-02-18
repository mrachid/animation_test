//
//  TodayDetailInteractor.swift
//  wizz_animation
//
//  Created by Rachid Mahmoud on 26/10/2021.
//

import Foundation

protocol TodayDetailBusinessLogic {
    func getUserPhotos(_ username: String, photoAnimation: Photo)
}

class TodayDetailInteractor {
    private let presenter: TodayDetailPresentationLogic
    private let worker: TodayDetailWorker
    
    init(presenter: TodayDetailPresentationLogic, worker: TodayDetailWorker) {
        self.presenter = presenter
        self.worker = worker
    }
}

extension TodayDetailInteractor: TodayDetailBusinessLogic {
    func getUserPhotos(_ username: String, photoAnimation: Photo) {
        worker.getUserPhotos(username) { result in
            switch result {
            case .success(let photos):
                self.presenter.presentUserPhotos(photos, photoAnimation: photoAnimation)
                self.getStatisticsPhoto(id: photoAnimation.id)
            case let .failure(error, _):
                self.presenter.presentError(error)
            }
        }
    }
    
    func getStatisticsPhoto(id: String) {
        worker.getStatisticsPhoto(id: id) { result in
            switch result {
            case .success(let statistics):
                self.presenter.presentStatisticsPhoto(statistics)
            case let .failure(error, _):
                self.presenter.presentError(error)
            }
        }
    }
}
