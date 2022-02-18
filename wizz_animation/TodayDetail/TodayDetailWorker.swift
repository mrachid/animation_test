//
//  TodayDetailWorker.swift
//  wizz_animation
//
//  Created by Rachid Mahmoud on 26/10/2021.
//

import Foundation

protocol TodayDetailAPIServiceProtocol {
    func getUserPhotos(_ username: String, completion: @escaping (Result<[Photo]>) -> Void)
    func getStatisticsPhoto(id: String, completion: @escaping (Result<Statistics>) -> Void)
}

class TodayDetailWorker {
    private let apiService: TodayDetailAPIServiceProtocol
    
    init(apiService: TodayDetailAPIServiceProtocol) {
        self.apiService = apiService
    }
    
    func getUserPhotos(_ username: String, completion: @escaping (Result<[Photo]>) -> Void) {
        apiService.getUserPhotos(username, completion: completion)
    }
    
    func getStatisticsPhoto(id: String, completion: @escaping (Result<Statistics>) -> Void) {
        apiService.getStatisticsPhoto(id: id, completion: completion)
    }
}

struct TodayDetailAPIService: TodayDetailAPIServiceProtocol {
    func getUserPhotos(_ username: String, completion: @escaping (Result<[Photo]>) -> Void) {
        WebServicesManager.httpRequest(
            forPath: TodayDetailAPIConstants.users.userPath(username: username),
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
    
    func getStatisticsPhoto(id: String, completion: @escaping (Result<Statistics>) -> Void) {
        WebServicesManager.httpRequest(
            forPath: TodayDetailAPIConstants.users.photoStatisticsPath(id: id),
            httpMethod: HttpMethod.get,
            completionHandler: { result in
                switch result {
                case .success(let data):
                    if let json = data as? JSONObject, let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []), let stats = try? JSONDecoder().decode(Statistics.self, from: jsonData) {
                        completion(.success(stats))
                    }
                case .failure(let error, _):
                    completion(.failure(error, nil))
                }
            }
        )
    }
}



private enum TodayDetailAPIConstants: String {
    case users = "users"
    case statistics = "statistics"
    
    func userPath(username: String) -> String {
        return TodayDetailAPIConstants.users.rawValue + "/" + username + "/photos"
    }
    
    func photoStatisticsPath(id: String) -> String {
        return "photos/" + id + "/" + TodayDetailAPIConstants.statistics.rawValue
    }
    
}

