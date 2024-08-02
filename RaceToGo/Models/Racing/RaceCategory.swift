//
//  RaceCategory.swift
//  RaceToGo
//
//  Created by Ekaterina Rodionova on 31/7/2024.
//

import Foundation

enum RaceCategory: Decodable, CaseIterable {
    case horse
    case harness
    case greyhound

    // MARK: - Init

    init?(from idString: String) {
        switch idString {
        case "9daef0d7-bf3c-4f50-921d-8e818c60fe61":
            self = .greyhound
        case "161d9be2-e909-4326-8c2c-35ed71fb460b":
            self = .harness
        case "4a2788f8-e825-4d36-9894-efd4baf1cfae":
            self = .horse
        default:
            return nil
        }
    }

    // MARK: - Calculated variables

    var name: String {
        switch self {
        case .greyhound:
            return String(localized: "Greyhound")
        case .harness:
            return String(localized: "Harness")
        case .horse:
            return String(localized: "Horse")
        }
    }

    var emoji: String {
        switch self {
        case .greyhound:
            return "🐶"
        case .harness:
            return "🐴"
        case .horse:
            return "🏇🏻"
        }
    }
}

// MARK: - Identifiable

extension RaceCategory: Identifiable {
    var id: Self { self }
}
