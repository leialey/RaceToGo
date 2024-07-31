//
//  Decodable+Mockable.swift
//  RaceToGo
//
//  Created by Ekaterina Rodionova on 31/7/2024.
//

import Foundation

protocol Mockable {
    associatedtype Mock: RawRepresentable where Mock.RawValue: StringProtocol
}

extension Decodable where Self: Mockable {
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
}
