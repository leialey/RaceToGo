//
//  RaceViewModelTests.swift
//  RaceToGoTests
//
//  Created by Ekaterina Rodionova on 31/7/2024.
//

import XCTest
@testable import RaceToGo

final class RaceViewModelTests: MockedDependenciesTestCase {
    func test_init_returnsCorrect() {
        // given race
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
    }
}
