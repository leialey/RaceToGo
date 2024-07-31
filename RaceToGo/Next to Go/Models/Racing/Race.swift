//
//  Race.swift
//  RaceToGo
//
//  Created by Ekaterina Rodionova on 31/7/2024.
//

import Foundation

struct Race: Decodable, Identifiable {
    let id: String
    let number: Int
    let name: String
    let category: RaceCategory?
    let meetingName: String
    let advertisedStart: Date
}
