//
//  MockAPIService.swift
//  RaceToGo
//
//  Created by Ekaterina Rodionova on 31/7/2024.
//

import Foundation

// Used for unit tests and previews
final class MockAPIService: APIServiceProtocol {
    var data: [String: Data]
    var error: CustomError = APIError.badResponse

    init(data: [String : Data] = [:]) {
        self.data = data
    }

    func request<T: Decodable>(route: APIProtocol) async throws -> T {
        if let success = data[route.description] {
            return try decode(from: success)
        } else {
            throw error
        }
    }
}
