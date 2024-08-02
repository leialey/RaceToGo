//
//  ErrorAlert.swift
//  RaceToGo
//
//  Created by Ekaterina Rodionova on 31/7/2024.
//

import Foundation

// Used to display error alerts in SwiftUI views
struct ErrorAlertViewModel: Identifiable {
    let id = UUID()
    let title = String(localized: "Oops")
    let description: String

    init(from error: Error) {
        if let error = error as? CustomError {
            #if DEBUG
            self.description = error.developerFacingError
            #else
            self.description = error.userFacingError
            #endif
        } else {
            self.description = String(localized: "There was an error")
        }
    }
}
