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
    private var date: Date!

    override func setUp() {
        super.setUp()
        // Provide a date close to dates in NextRacesResponse mock
        date = Date(timeIntervalSince1970: 1722576240)
        sut = NextRacesViewModel(apiService: apiService, date: date)
    }

    override func tearDown() {
        sut = nil
        date = nil
        super.tearDown()
    }

    // MARK: - Fetch next races

    func test_fetchNextRaces_givenSuccess_assignsRaces() async {
        // given API returns success
        await givenFetchedRaces()

        // then fetches 5 races
        XCTAssertEqual(sut.fetchedRaces.count, 10)
    }

    func test_fetchNextRaces_givenAPIFailure_showsAnError() async {
        // given API request fails
        await sut.fetchNextRaces()

        // then
        XCTAssertTrue(sut.racesStartingSoon.isEmpty)
        try! await Task.sleep(nanoseconds: 200000000)
        XCTAssertEqual(sut.errorAlert?.title, "Oops")
    }

    // MARK: - Should fetch new data

    func test_fetchNextRaces_givenNextFetch_showsAnError() async {
        // given API returns success
        await givenFetchedRaces()

        // then wait for 2 races to expire (past 1 min since start)
        sut.date = date.addingTimeInterval(2 * 60)
        XCTAssertFalse(sut.shouldFetchNewData)
        // then wait for 1 more race to expire (7 left)
        sut.date = date.addingTimeInterval(3 * 60)
        // then needs to fetch new data
        XCTAssertTrue(sut.shouldFetchNewData)
    }

    // MARK: - Race view models

    func test_raceViewModels_givenFetchedRaces_areCorrect() async {
        // given fetched races
        await givenFetchedRaces()

        // when
        let result = sut.raceViewModels

        // then there are 5 race view models, they are sorted by date ascending
        XCTAssertEqual(result.count, 5)
        XCTAssertEqual(result[0].startsInString, "0s.")
        XCTAssertEqual(result[1].startsInString, "1m")
        XCTAssertEqual(result[2].startsInString, "2m")
        XCTAssertEqual(result[3].startsInString, "3m")
        XCTAssertEqual(result[4].startsInString, "6m")
    }

    func test_raceViewModels_givenFetchedRaces_whenWaitAMinute_racesDisappear() async {
        // given fetched races
        await givenFetchedRaces()

        // when
        let result = sut.raceViewModels
        XCTAssertEqual(result[0].meetingName, "Coffs Harbour")
        XCTAssertEqual(result[1].meetingName, "Addington")

        // then nothing changes after 59 seconds
        sut.date = date.addingTimeInterval(59)
        XCTAssertEqual(sut.raceViewModels[0].meetingName, "Coffs Harbour")
        // then the 1st race disappears after 60 seconds, next race becomes 1st
        sut.date = date.addingTimeInterval(60)
        XCTAssertEqual(sut.raceViewModels[0].meetingName, "Addington")
        XCTAssertEqual(sut.raceViewModels[0].startsInString, "0s.")
    }

    func test_raceViewModels_givenFetchedRaces_andFilteredByCategory_displaysFilteredRaces() async {
        // given fetched races
        await givenFetchedRaces()
        XCTAssertEqual(sut.raceViewModels.count, 5)

        // when filtered by Horse
        sut.selectedCategories = sut.selectedCategories.map { .init(category: $0.category, isOn: $0.category == .horse) }

        // then shows only 4 of 5 races
        XCTAssertEqual(sut.raceViewModels.count, 4)
    }
}

private extension NextRacesViewModelTests {
    private func givenFetchedRaces() async {
        apiService.data["next races"] = NextRacesResponse.mock()
        await sut.fetchNextRaces()
    }
}
