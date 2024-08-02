//
//  RaceViewModel.swift
//  RaceToGo
//
//  Created by Ekaterina Rodionova on 31/7/2024.
//

import Foundation

struct RaceViewModel: Identifiable {
    let id: String
    let categoryEmoji: String
    let categoryName: String
    let raceNumber: String
    let meetingName: String
    let timeLeftString: String
    let timeLeftA11yLabel: String

    init(race: Race, date: Date) {
        id = race.id
        categoryEmoji = race.category?.emoji ?? ""
        categoryName = race.category?.name ?? ""
        raceNumber = String(localized: "R\(race.number)")
        meetingName = race.meetingName
        let timeInterval = date.distance(to: race.advertisedStart)
        timeLeftString = Self.getFormattedTime(for: timeInterval, forAccessibility: false)
        let formattedForA11y = Self.getFormattedTime(for: timeInterval, forAccessibility: true)
        timeLeftA11yLabel = String(localized: "starts in \(formattedForA11y)")
    }

    private static func getFormattedTime(for timeInterval: TimeInterval, forAccessibility: Bool) -> String {
        // Voice over doesn't pronounce abbreviated string correctly e.g. saying meters instead of minutes,
        // so need to use full units style
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = forAccessibility ? .full : .abbreviated
        return formatter.string(from: timeInterval) ?? ""
    }
}
