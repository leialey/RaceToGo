//
//  APIProtocol.swift
//  RaceToGo
//
//  Created by Ekaterina Rodionova on 31/7/2024.
//

import Foundation

protocol APIProtocol {
    var description: String { get } // used for unit tests
    var method: APIMethod { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
    func asURLRequest() throws -> URLRequest
}

extension APIProtocol {

    static private var defaultHeaders: [String: String] {
        [
            "User-Agent": APIConstants.userAgent,
            "Accept": APIConstants.accept
        ]
    }

    func asURLRequest() throws -> URLRequest {
        guard var urlComponents = URLComponents(string: path) else {
            throw APIError.invalidURL(path: path)
        }
        if !queryItems.isEmpty {
            urlComponents.queryItems = queryItems
        }
        guard let url = urlComponents.url else {
            throw APIError.invalidURL(path: urlComponents.path)
        }
        var urlRequest = URLRequest(url: url)
        Self.defaultHeaders.forEach {
            urlRequest.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        urlRequest.httpMethod = method.rawValue.uppercased()
        return urlRequest
    }
}

