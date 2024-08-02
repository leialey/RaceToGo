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
                filtersSection
                racesSection
            }
            .refreshable {
                await viewModel.fetchNextRaces()
            }
            .overlay(
                EmptyListView(viewModel: viewModel.emptyListViewModel)
            )
            .animation(.default, value: viewModel.selectedCategories)
        }
        .task {
            await viewModel.fetchNextRaces()
        }
    }

    // MARK: - Subviews

    private var filtersSection: some View {
        Section {
            filtersView
        } header: {
            Text("Filters")
        }
    }

    private var racesSection: some View {
        Section {
            ForEach(viewModel.raceViewModels) { raceViewModel in
                RaceListRow(viewModel: raceViewModel)
            }
        } header: {
            Text("Next to go racing")
        } footer: {
            footerView
        }
    }

    private var filtersView: some View {
        ForEach($viewModel.selectedCategories) { $filter in
            ToggleView(
                isOn: $filter.isOn,
                title: filter.category.name,
                emoji: filter.category.emoji
            )
        }
    }

    private var footerView: some View {
        ProgressView()
            .frame(maxWidth: .infinity)
            .padding()
            .opaqueIfTrue(viewModel.isLoading)
    }
}

#Preview {
    NextRacesView(
        viewModel: NextRacesViewModel(
            apiService: MockAPIService(data: [
                "next races": NextRacesResponse.mock()
            ]),
            advertisedStartLimit: -.infinity
        )
    )
}
