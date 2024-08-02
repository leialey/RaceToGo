//
//  MockAPIService.swift
//  RaceToGo
//
//  Created by Ekaterina Rodionova on 31/7/2024.
//

import Foundation

// Used for unit tests and previews
// Just pass description of an APIProtocol, e.g. "next races" with its mock for the request to return a success
final class MockAPIService: APIServiceProtocol {
    var data: [String: Data]
    var error: CustomError = APIError.badResponse

    init(data: [String: Data] = [:]) {
        self.data = data
    }

    func request<T: Decodable>(route: APIProtocol) async throws -> T {
        if let success = data[route.description] {
            return try APIConstants.customJSONDecoder.decode(T.self, from: success)
        } else {
            throw error
        }
    }
}
