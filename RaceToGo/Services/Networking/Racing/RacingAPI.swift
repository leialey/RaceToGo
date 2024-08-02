//
//  NextRacesAPI.swift
//  RaceToGo
//
//  Created by Ekaterina Rodionova on 31/7/2024.
//

import Foundation

// E.g. next 10 races: https://api.neds.com.au/rest/v1/racing/?method=nextraces&count=10

enum RacingAPI: APIProtocol {
    case nextRaces(limit: Int)

    var description: String {
        switch self {
        case .nextRaces:
            return "next races"
        }
    }

    var method: APIMethod {
        switch self {
        case .nextRaces:
            return .get
        }
    }

    var path: String {
        switch self {
        case .nextRaces:
            return "\(APIConstants.baseURLString)/racing/"
        }
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case .nextRaces(let limit):
            return [
                .init(name: "method", value: "nextraces"),
                .init(name: "count", value: String(limit))
            ]
        }
    }
}
