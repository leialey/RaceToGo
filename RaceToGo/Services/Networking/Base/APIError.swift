//
//  APIError.swift
//  RaceToGo
//
//  Created by Ekaterina Rodionova on 31/7/2024.
//

import Foundation

enum APIError: CustomError {
    case decodingError(error: Error)
    case invalidURL(path: String)
    case badRequest(errorCode: Int)
    case badResponse

    // Error presented to user - needs to be localized
    var userFacingError: String {
        switch self {
        case .decodingError, .invalidURL, .badRequest, .badResponse:
            return String(localized: "There was an error fetching data")
        }
    }

    // Error presented to developer for debugging purposes - doesn't need to be localized
    var developerFacingError: String {
        switch self {
        case .decodingError:
            return "There was a decoding error"
        case .invalidURL(let path):
            return "URL for this path is invalid: \(path)"
        case .badRequest(let errorCode):
            return "API request failed with \(errorCode)"
        case .badResponse:
            return "Response is not HTTPURLResponse"
        }
    }
}
