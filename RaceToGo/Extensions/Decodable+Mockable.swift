//
//  Decodable+Mockable.swift
//  RaceToGo
//
//  Created by Ekaterina Rodionova on 31/7/2024.
//

import Foundation

// Create mocks from real json payload.
// Mocks can be used for previews and unit tests.
protocol Mockable {
    associatedtype Mock: RawRepresentable where Mock.RawValue: StringProtocol
}

extension Decodable where Self: Mockable {
    // Finds mock file with the same name as the Data type, finds the mock by the specified key and transforms to Data
    // E.g. "normal" mock in NextRacesResponse.json file
    static func mock(_ key: Self.Mock? = nil) -> Data {
        let key = (key?.rawValue as? String) ?? "normal"
        guard
            let url = Bundle.main.url(forResource: String(describing: Self.self), withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
            let conditionJson = json[key] as? [String: Any],
            let typeData = try? JSONSerialization.data(withJSONObject: conditionJson) else {
            fatalError("Unable to serialize the json file")
        }
        return typeData
    }

    static func mockDecoded(_ key: Self.Mock? = nil) -> Self {
        let data = mock(key)
        guard let decodedObject = try? APIConstants.customJSONDecoder.decode(Self.self, from: data) else {
            fatalError("Unable to decode object")
        }
        return decodedObject
    }
}
