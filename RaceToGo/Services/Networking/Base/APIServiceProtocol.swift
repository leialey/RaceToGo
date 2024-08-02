//
//  APIServiceProtocol.swift
//  RaceToGo
//
//  Created by Ekaterina Rodionova on 2/8/2024.
//

import Foundation

protocol APIServiceProtocol: AnyObject {
    func request<T: Decodable>(route: APIProtocol) async throws -> T
}
