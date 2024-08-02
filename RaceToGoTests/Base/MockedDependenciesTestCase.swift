//
//  MockedDependenciesTestCase.swift
//  RaceToGoTests
//
//  Created by Ekaterina Rodionova on 31/7/2024.
//

import XCTest
@testable import RaceToGo

class MockedDependenciesTestCase: XCTestCase {
    var apiService: MockAPIService!

    override func setUp() {
        super.setUp()
        apiService = MockAPIService()
    }
}
