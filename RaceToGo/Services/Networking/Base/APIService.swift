//
//  BaseNetworkingService.swift
//  RaceToGo
//
//  Created by Ekaterina Rodionova on 31/7/2024.
//

import Foundation

protocol APIServiceProtocol: AnyObject {
    func request<T: Decodable>(route: APIProtocol) async throws -> T
    func decode<T: Decodable>(from data: Data) throws -> T
}

extension APIServiceProtocol {
    func decode<T: Decodable>(from data: Data) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .secondsSince1970
        return try decoder.decode(T.self, from: data)
    }
}

final class APIService: APIServiceProtocol {
    typealias T = Decodable

    func request<T: Decodable>(route: APIProtocol) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: route.asURLRequest())
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.badResponse
        }

        switch httpResponse.statusCode {
        case 200:
            do {
                #if DEBUG
                print("Received 200 response with json: \(data.toJsonString() ?? "nil")")
                #endif
                return try decode(from: data)
            } catch {
                #if DEBUG
                print(error)
                #endif
                throw APIError.decodingError(error: error)
            }
        default:
            throw APIError.badRequest(errorCode: httpResponse.statusCode)
        }
    }
}
