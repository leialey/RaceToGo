//
//  NextRacesResponse.swift
//  RaceToGo
//
//  Created by Ekaterina Rodionova on 31/7/2024.
//

import Foundation

struct NextRacesResponse: Decodable {
    let status: Int
    let data: Data

    struct Data: Decodable {
        let raceSummaries: [String: RaceSummary]
    }

    struct RaceSummary: Decodable {
        let raceId: String
        let raceNumber: Int
        let raceName: String
        let categoryId: String
        let meetingName: String
        let advertisedStart: AdvertisedStart
    }

    struct AdvertisedStart: Decodable {
        let seconds: Date
    }
}

extension NextRacesResponse {
    func toRaces() -> [Race] {
        data.raceSummaries.map {
            let summary = $0.value
            return Race(
                id: summary.raceId,
                number: summary.raceNumber,
                name: summary.raceName,
                category: .init(from: summary.categoryId),
                meetingName: summary.meetingName,
                advertisedStart: summary.advertisedStart.seconds
            )
        }
    }
}
