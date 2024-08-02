//
//  RaceViewModelTests.swift
//  RaceToGoTests
//
//  Created by Ekaterina Rodionova on 31/7/2024.
//

import XCTest
@testable import RaceToGo

final class RaceViewModelTests: XCTestCase {
    func test_init_givenRaceStartsSoon_assignsCorrectProperties() {
        // given race in 65 seconds
        // when init
        let sut = givenSut(raceIn: 65)

        // then
        XCTAssertEqual(sut.startsInString, "1m 5s.")
        XCTAssertEqual(sut.startsInA11yLabel, "starts in 1 minute, 5 seconds")
        XCTAssertEqual(sut.categoryEmoji, "🏇🏻")
        XCTAssertEqual(sut.categoryName, "Horse")
        XCTAssertEqual(sut.meetingName, "Meeting")
        XCTAssertEqual(sut.raceNumber, "R1")
        XCTAssertEqual(sut.id, "123")
    }

    func test_timeLeftString_givenRaceStartingNow_returnsZeroSeconds() {
        // given race right now
        // when init
        let sut = givenSut(raceIn: 0)

        // then
        XCTAssertEqual(sut.startsInString, "0s.")
    }

    func test_timeLeftString_givenRaceStarted_returnsNegativeSeconds() {
        // given race already started
        // when init
        let sut = givenSut(raceIn: -1)

        // then
        XCTAssertEqual(sut.startsInString, "-1s.")
    }
}

private extension RaceViewModelTests {
    func givenSut(raceIn timeInterval: TimeInterval) -> RaceViewModel {
        let date = Date()
        let race = Race(
            id: "123",
            number: 1,
            name: "Race",
            category: .horse,
            meetingName: "Meeting",
            advertisedStart: date.addingTimeInterval(timeInterval)
        )
        return RaceViewModel(race: race, date: date)
    }
}
