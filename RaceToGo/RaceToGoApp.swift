//
//  RaceToGoApp.swift
//  RaceToGo
//
//  Created by Ekaterina Rodionova on 31/7/2024.
//

import SwiftUI

@main
struct RaceToGoApp: App {

    // MARK: - Dependencies

    let apiService = APIService()

    var body: some Scene {
        WindowGroup {
            NextRacesView(viewModel: NextRacesViewModel(apiService: apiService))
        }
    }
}
