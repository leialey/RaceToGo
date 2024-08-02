//
//  Data+Extensions.swift
//  RaceToGo
//
//  Created by Ekaterina Rodionova on 31/7/2024.
//

import Foundation

extension Data {
    func toJsonString() -> String? {
        guard let jsonObject = try? JSONSerialization.jsonObject(with: self),
              let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
            return nil
        }
        return String(decoding: jsonData, as: UTF8.self)
    }
}
