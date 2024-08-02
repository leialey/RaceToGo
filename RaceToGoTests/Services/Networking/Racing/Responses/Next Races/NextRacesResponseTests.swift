//
//  NextRacesResponseTests.swift
//  RaceToGoTests
//
//  Created by Ekaterina Rodionova on 2/8/2024.
//

import XCTest
@testable import RaceToGo

final class NextRacesResponseTests: XCTestCase {
    func test_nextRacesResponse_isDecodedCorrectly() {
        // given mocked response
        let sut = NextRacesResponse.mockDecoded()

        // then the data is decoded correctly
        XCTAssertEqual(sut.data.raceSummaries.count, 10)
    }

    func test_toRaces_returnsCorrectRaces() {
        // given mocked response
        let sut = NextRacesResponse.mockDecoded()

        // when coverted to races
        let result = sut.toRaces()

        // then the races data is correct
        XCTAssertEqual(result.count, 10)
        let firstRace = result.first(where: { $0.id == "8630db92-60f3-4489-9bca-1066758e2270" })
        XCTAssertEqual(firstRace?.advertisedStart, .init(timeIntervalSince1970: 1722576300))
        XCTAssertEqual(firstRace?.category, .harness)
        //XCTAssertEqual(firstRace.id, "8630db92-60f3-4489-9bca-1066758e2270")
        XCTAssertEqual(firstRace?.meetingName, "Addington")
        XCTAssertEqual(firstRace?.number, 2)
        XCTAssertEqual(firstRace?.name, "Concrete Brothers Trot")
    }
}
