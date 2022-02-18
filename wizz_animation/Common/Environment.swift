//
//  Environment.swift
//  wizz_animation
//
//  Created by Rachid Mahmoud on 26/10/2021.
//

import Foundation

enum Environment: String {
    case unsplashApi = "api.unsplash"
    
    public var baseURL: String {
        return "https://" + Environment.unsplashApi.rawValue + ".com/"
    }
}

struct HttpError {
    static let domain = "HttpError.domain"
    static let badRequest = 400
    static let unauthorized = 401
    static let forbidden = 403
    static let notFound = 404
    static let internalServerError = 500
    static let serverError = 503
    static let jsonReading = 0001
    
    static let httpCodes = [badRequest, unauthorized, forbidden, notFound, internalServerError, serverError, jsonReading]
}

struct HttpCode {
    enum Success: Int {
        case ok = 200
        case noContent = 204
        
        static func httpCodeContains(code: Int) -> Bool {
            return [Success.ok.rawValue, Success.noContent.rawValue].contains(code)
        }
    }
}

extension NSError {
    struct Constants {
        static let httpStatusCode = "httpStatusCode"
        static let errorCode = "errorCode"
    }
    
    static func httpError(with code: Int) -> NSError? {
        if !HttpCode.Success.httpCodeContains(code: code) {
            return NSError(domain: HttpError.domain, code: code, userInfo:
                            [
                                NSLocalizedFailureReasonErrorKey: HTTPURLResponse.localizedString(forStatusCode: code)
                            ])
        }
        return nil
    }
}
