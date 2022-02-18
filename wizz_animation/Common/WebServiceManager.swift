//
//  WebServiceManager.swift
//  wizz_animation
//
//  Created by Rachid Mahmoud on 26/10/2021.
//

import Foundation
import UIKit

public typealias JSONObject = [String: Any]

enum HttpMethod: String {
    case get = "GET"
}

enum WebServiceType: Int {
    case catalog = 0
    case travel
}

enum Result<T> {
    case success(T)
    case failure(NSError, T?)
}

public class WebServicesManager: NSObject {
    class func httpRequest(forPath path: String,
                           httpMethod: HttpMethod,
                           bodyObject: Any? = nil,
                           customHeaders: [String: String] = [String: String](),
                           completionHandler: @escaping (Result<Any>) -> Void) {
        
        let encodedPath = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: Environment.unsplashApi.baseURL + encodedPath) else {
            completionHandler(.failure(NSError(domain: HttpError.domain, code: HttpError.notFound, userInfo: nil), nil))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        defaultHeaders.forEach { request.setValue($0.1, forHTTPHeaderField: $0.0) }
        let task = sharedSession.dataTask(with: request, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                if let error = defineError(with: response), let response = response as? HTTPURLResponse {
                    let error = NSError(domain: error.domain, code: response.statusCode, userInfo: error.userInfo)
                    completionHandler(.failure(error, nil))
                    
                    
                } else if let error = defineError(with: response) ?? error {
                    completionHandler(.failure(error as NSError, nil))
                }
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                
                let error = defineError(with: response) ?? error
                
                if let error = error {
                    completionHandler(.failure(error as NSError, json))
                } else {
                    completionHandler(.success(json))
                }
            } catch let jsonError as NSError {
                print("Error while parsing JSON : \(jsonError.localizedDescription)")
                let error = defineError(with: response) ?? jsonError
                completionHandler(.failure(error, nil))
            }
        })
        task.resume()
    }
}

fileprivate extension WebServicesManager {
    static var sharedSession: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
        
    }()
    
    static var defaultHeaders: [String: String] = {
        [
            "Authorization" : "Client-ID \(accessKey)",
            "Accept-Version": "v1",
            "Content-Type": "application/json",
        ]
    }()
    
    static var accessKey: String = "Tcu-5J6yv6MkuVtZXBuun2DAQ-8WGtaZoAnT9P3rquo"
    
    class func httpError(with httpStatusCode: Int) -> NSError? {
        return NSError.httpError(with: httpStatusCode)
    }
    
    class func defineError(with response: URLResponse?) -> NSError? {
        if let httpUrlResponse = response as? HTTPURLResponse {
            if let httpError = httpError(with: httpUrlResponse.statusCode) {
                return httpError
            }
        }
        return nil
    }
}
