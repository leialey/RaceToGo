//
//  RaceToGoApp.swift
//  RaceToGo
//
//  Created by Ekaterina Rodionova on 31/7/2024.
//

import SwiftUI

@main
struct RaceToGoApp: App {
    @StateObject private var viewModel = AppViewModel()

    var body: some Scene {
        WindowGroup {
            NextRacesView(viewModel: NextRacesViewModel(apiService: viewModel.apiService))
        }
    }
}
