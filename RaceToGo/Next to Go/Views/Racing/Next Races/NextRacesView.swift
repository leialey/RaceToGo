//
//  NextRacesView.swift
//  RaceToGo
//
//  Created by Ekaterina Rodionova on 31/7/2024.
//

import SwiftUI

struct NextRacesView: View {
    @StateObject var viewModel: NextRacesViewModel

    var body: some View {
        BaseView(viewModel: viewModel) {
            List {
                Section {
                    filtersView
                } header: {
                    Text("Filters")
                }
                Section {
                    ForEach(viewModel.raceViewModels) { raceViewModel in
                        RaceListRow(viewModel: raceViewModel)
                    }
                } header: {
                    Text(viewModel.title)
                } footer: {
                    footerView
                }
            }
        }
        .task {
            await viewModel.fetchNextRaces()
        }
    }

    // MARK: - Subviews

    private var filtersView: some View {
        ForEach(viewModel.allCategories) { category in
            Toggle(isOn: .init(get: {
                viewModel.selectedCategories.contains(category)
            }, set: { bool in
                viewModel.selectedCategories.append(category)
            }), label: {
                Label(
                    title: { Text(category.name) },
                    icon: { Text(category.emoji) }
                )
            })
        }
    }

    private var footerView: some View {
        ProgressView()
            .frame(maxWidth: .infinity)
            .padding()
            .opacity(viewModel.isLoading ? 1 : 0)
    }
}

#Preview {
    NextRacesView(
        viewModel: NextRacesViewModel(
            apiService: MockAPIService(),
            date: Date(timeIntervalSince1970: 1722411838)
        )
    )
}
