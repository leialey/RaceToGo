//
//  NextRacesViewModelTests.swift
//  RaceToGoTests
//
//  Created by Ekaterina Rodionova on 31/7/2024.
//

import XCTest
@testable import RaceToGo

final class NextRacesViewModelTests: MockedDependenciesTestCase {
    private var sut: NextRacesViewModel!

    override func setUp() {
        super.setUp()
        apiService = MockAPIService()
        sut = NextRacesViewModel(apiService: apiService, date: .distantPast)
    }

    func test_fetchNextRaces_givenSuccess_assignsRaces() async {
        // given API returns success
        apiService.data["RacingAPI"] = NextRacesResponse.mock()

        // when
        await sut.fetchNextRaces()

        // then returns 5 races
        XCTAssertEqual(sut.filteredRaces.count, 5)
        //XCTAssertEqual(sut.filteredRaces[0].advertisedStart, Date())
    }

    func test_fetchNextRaces_givenAPIFailure_showsAnError() async {
        // given API request fails
        apiService = MockAPIService()

        // when
        await sut.fetchNextRaces()

        // then
        XCTAssertTrue(sut.filteredRaces.isEmpty)
        XCTAssertEqual(sut.errorAlert?.title, "Oops")
        //XCTAssertEqual(sut.errorAlert?.description, "There was an error")
    }
}
