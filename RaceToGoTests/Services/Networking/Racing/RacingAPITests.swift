//
//  APIProtocolTests.swift
//  RaceToGoTests
//
//  Created by Ekaterina Rodionova on 2/8/2024.
//

import XCTest
@testable import RaceToGo

final class RacingAPITests: XCTestCase {
    func test_asURLRequest_returnsCorrectRequest() {
        // given Racing API
        let sut = RacingAPI.nextRaces(limit: 10)
        
        // when forms a URL request
        let result = try! sut.asURLRequest()
        
        // then the request has correct attributes
        XCTAssertEqual(result.url?.absoluteString, "https://api.neds.com.au/rest/v1/racing/?method=nextraces&count=10")
        XCTAssertEqual(result.httpMethod, "GET")
        XCTAssertEqual(result.allHTTPHeaderFields?.count, 2)
        XCTAssertEqual(result.allHTTPHeaderFields?["User-Agent"], "RaceToGo iOS")
        XCTAssertEqual(result.allHTTPHeaderFields?["Accept"], "application/json")
    }
}
