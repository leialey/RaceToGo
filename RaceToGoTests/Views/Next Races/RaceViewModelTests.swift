//
//  RaceViewModelTests.swift
//  RaceToGoTests
//
//  Created by Ekaterina Rodionova on 31/7/2024.
//

import XCTest
@testable import RaceToGo

final class RaceViewModelTests: XCTestCase {
    func test_init_returnsCorrect() {
        // given race in 65 seconds
        let date = Date()
        let race = Race(
            id: "123", number: 1, name: "Race",
            category: .horse, meetingName: "Meeting",
            advertisedStart: date.addingTimeInterval(65)
        )

        // when init
        let sut = RaceViewModel(race: race, date: date)

        // then
        XCTAssertEqual(sut.timeLeftString, "1m 5s.")
        XCTAssertEqual(sut.timeLeftA11yLabel, "starts in 1 minute 5 seconds")
        XCTAssertEqual(sut.categoryEmoji, "🏇🏻")
        XCTAssertEqual(sut.categoryName, "Horse")
        XCTAssertEqual(sut.meetingName, "Meeting")
        XCTAssertEqual(sut.raceNumber, "R1")
        XCTAssertEqual(sut.id, "123")
    }

    func test_timeLeftString_givenRaceStartingNow_returnsZeroSeconds() {
        // given race right now
        let date = Date()
        let race = Race(
            id: "123", number: 1, name: "Race",
            category: .horse, meetingName: "Meeting",
            advertisedStart: date
        )

        // when init
        let sut = RaceViewModel(race: race, date: date)

        // then
        XCTAssertEqual(sut.timeLeftString, "0s.")
    }

    func test_timeLeftString_givenRaceStarted_returnsNegativeSeconds() {
        // given race already started
        let date = Date()
        let race = Race(
            id: "123", number: 1, name: "Race",
            category: .horse, meetingName: "Meeting",
            advertisedStart: date.addingTimeInterval(-1)
        )

        // when init
        let sut = RaceViewModel(race: race, date: date)

        // then
        XCTAssertEqual(sut.timeLeftString, "-1s.")
    }
}
