//
//  TodayDetailPresenter.swift
//  wizz_animation
//
//  Created by Rachid Mahmoud on 26/10/2021.
//

import Foundation

protocol TodayDetailPresentationLogic {
    func presentUserPhotos(_ photos: [Photo], photoAnimation: Photo)
    func presentStatisticsPhoto(_ statistics: Statistics)
    func presentError(_ error: NSError)
}

class TodayDetailPresenter {
    private weak var viewController: TodayDetailDisplayLogic?
    
    init(viewController: TodayDetailDisplayLogic?) {
        self.viewController = viewController
    }
}

extension TodayDetailPresenter: TodayDetailPresentationLogic {
    func presentUserPhotos(_ photos: [Photo], photoAnimation: Photo) {
        var userPhotos: [String] = []
        
        photos.forEach {
            guard let image = $0.urls?.image else { return }
            if ($0.id != photoAnimation.id) {
                userPhotos.append(image)
            } else {
                
            }
        }
        
        userPhotos.insert(photoAnimation.urls?.image ?? "", at: 0)
        
        viewController?.displayUserPhotos(userPhotos)
    }
    
    func presentStatisticsPhoto(_ statistics: Statistics) {
        viewController?.displayStatisticsPhoto(statistics)
    }
    
    func presentError(_ error: NSError) {
        viewController?.displayError(error)
    }
}
