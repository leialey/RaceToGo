//
//  Constants.swift
//  RaceToGo
//
//  Created by Ekaterina Rodionova on 31/7/2024.
//

import Foundation

enum APIConstants {
    static let baseURLString = "https://api.neds.com.au/rest/v1"
    static let userAgent = "RaceToGo iOS"
    static let accept = "application/json"
    
    static var customJSONDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }
}
