//
//  Constant.swift
//  Movie
//
//  Created by Edo Oktarifa on 23/04/21.
//

import Foundation

struct Constants {
    static let base_url = "https://api.themoviedb.org/3/movie/100"
}

enum ApiResult {
    case success(data : Data)
    case failure(result : RequestError)
}

enum RequestError: Error {
    case unknownError
    case connectionError
    case authorizationError(AnyObject)
    case invalidRequest
    case notFound
    case invalidResponse
    case serverError
    case serverUnavailable
}
