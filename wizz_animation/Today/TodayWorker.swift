//
//  TodayWorker.swift
//  wizz_animation
//
//  Created by Rachid Mahmoud on 26/10/2021.
//

import Foundation

protocol TodayAPIServiceProtocol {
    func getPhotos(_ completion: @escaping (Result<[Photo]>) -> Void)
}

class TodayWorker {
    private let apiService: TodayAPIServiceProtocol
    
    init(apiService: TodayAPIServiceProtocol) {
        self.apiService = apiService
    }
    
    func getPhotos(_ completion: @escaping (Result<[Photo]>) -> Void) {
        apiService.getPhotos(completion)
    }
}

struct TodayAPIService: TodayAPIServiceProtocol {
    
    func getPhotos(_ completion: @escaping (Result<[Photo]>) -> Void) {
        WebServicesManager.httpRequest(
            forPath: TodayAPIConstants.photos.path(),
            httpMethod: HttpMethod.get,
            completionHandler: { result in
                switch result {
                case .success(let data):
                    if let json = data as? [JSONObject], let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []), let photos = try? JSONDecoder().decode([Photo].self, from: jsonData) {
                        completion(.success(photos))
                    }
                case .failure(let error, _):
                    completion(.failure(error, nil))
                }
            })
    }
}

private enum TodayAPIConstants: String {
    case photos = "photos"
    
    func path() -> String {
        return TodayAPIConstants.photos.rawValue
    }
    
}
