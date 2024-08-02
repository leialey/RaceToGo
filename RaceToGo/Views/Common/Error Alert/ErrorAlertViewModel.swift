//
//  ErrorAlert.swift
//  RaceToGo
//
//  Created by Ekaterina Rodionova on 31/7/2024.
//

import Foundation

// Used to display error alerts in SwiftUI views
struct ErrorAlertViewModel: Identifiable {
    let title = String(localized: "Oops")
    let description: String

    var id: String {
        title + description
    }

    init(from error: Error) {
        if let error = error as? CustomError {
            var description = error.userFacingError
            #if DEBUG
            description += "\nDEBUG: \(error.developerFacingError)"
            #endif
            self.description = description
        } else {
            self.description = String(localized: "There was an error")
        }
    }
}
