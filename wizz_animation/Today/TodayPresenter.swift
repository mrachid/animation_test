//
//  TodayPresenter.swift
//  wizz_animation
//
//  Created by Rachid Mahmoud on 26/10/2021.
//

import Foundation

protocol TodayPresentationLogic {
    func presentPhotos(_ photos: [Photo])
    func presentError(_ error: NSError)
}

class TodayPresenter {
    private weak var viewController: TodayDisplayLogic?
    
    init(viewController: TodayDisplayLogic?) {
        self.viewController = viewController
    }
}

extension TodayPresenter: TodayPresentationLogic {
    func presentPhotos(_ photos: [Photo]) {
        viewController?.displayPhoto(photos)
    }
    
    func presentError(_ error: NSError) {
        viewController?.displayError(error)
    }
}
