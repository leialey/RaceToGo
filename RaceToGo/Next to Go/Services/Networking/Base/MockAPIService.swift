//
//  MockAPIService.swift
//  RaceToGo
//
//  Created by Ekaterina Rodionova on 31/7/2024.
//

import Foundation

// Used for unit tests and previews
class MockAPIService: APIServiceProtocol {
    var data: [String: Data] = [
        "RacingAPI": NextRacesResponse.mock()
    ]

    func request<T: Decodable>(route: APIProtocol) async throws -> T {
        switch route {
        case is RacingAPI:
            if let success = data["RacingAPI"] {
                return try decode(from: success)
            } else {
                throw APIError.badResponse
            }
        default:
            fatalError("API not handled")
        }
    }
}
