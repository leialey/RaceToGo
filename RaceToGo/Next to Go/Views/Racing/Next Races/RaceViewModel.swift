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
    let raceNumber: String
    let meetingName: String
    let timeLeftString: String

    init(race: Race, date: Date) {
        id = race.id
        categoryEmoji = race.category?.emoji ?? " "
        raceNumber = String(localized: "R\(race.number)")
        meetingName = race.meetingName
        #warning("TODO: crash when negative")
        let interval: Range<Date>
        if date < race.advertisedStart {
            timeLeftString = (date..<race.advertisedStart).formatted(.components(style: .narrow))
        } else {
            timeLeftString = "-" + (race.advertisedStart..<date).formatted(.components(style: .narrow))
        }
    }
}
