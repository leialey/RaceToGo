//
//  NextRacesViewModel.swift
//  RaceToGo
//
//  Created by Ekaterina Rodionova on 31/7/2024.
//

import Foundation
import Combine
import SwiftUI

final class NextRacesViewModel: BaseViewModel {

    // MARK: - Constants

    // How many races to display
    private let raceLimit = 5

    // How many races to fetch at once
    private let raceLimitToFetch = 10

    // When reaching this number of not expired races, fetch new data
    private let raceIndexToFetchNext = 7

    // Do not display races that are over 1 min past the advertised start
    private let advertisedStartLimit: TimeInterval

    // MARK: - Variables

    @Published private(set) var fetchedRaces: [Race] = []

    @Published var selectedCategories: [CategoryFilterViewModel] = RaceCategory.allCases.map {
        .init(category: $0, isOn: true)
    }

    private lazy var autoplayTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private var timerSubscription: AnyCancellable?

    // MARK: - Calculated variables

    var raceViewModels: [RaceViewModel] {
        racesStartingSoon
            .filter { race in
                selectedCategories.contains(where: { $0.isOn && $0.category == race.category })
            }
            .sorted(by: { $0.advertisedStart < $1.advertisedStart })
            .prefix(raceLimit)
            .map { .init(race: $0, date: date) }
    }

    var racesStartingSoon: [Race] {
        fetchedRaces.filter({ date.distance(to: $0.advertisedStart) > advertisedStartLimit })
    }

    var allCategories: [RaceCategory] {
        RaceCategory.allCases
    }

    var emptyListViewModel: EmptyListViewModel {
        let filterApplied = selectedCategories.filter({ $0.isOn }).count < allCategories.count
        let isEmptyList = raceViewModels.isEmpty && !isLoading
        return .init(
            title: String(localized: "No races found"),
            subtitle: filterApplied ? String(localized: "Try to remove filters") : nil,
            condition: isEmptyList
        )
    }

    var shouldFetchNewData: Bool {
        // Could API return less than 10 races at some point?
        // In that case perhaps no need to fetch new races
        racesStartingSoon.count <= raceIndexToFetchNext && fetchedRaces.count >= raceLimitToFetch
    }

    // MARK: - Dependencies

    @Published var date: Date
    private let apiService: APIServiceProtocol

    // MARK: - Lifecycle

    init(apiService: APIServiceProtocol, date: Date = Date(), advertisedStartLimit: TimeInterval = -60) {
        self.apiService = apiService
        self.date = date
        self.advertisedStartLimit = advertisedStartLimit
    }

    // MARK: - Public

    @MainActor
    func fetchNextRaces() async {
        isLoading = true
        do {
            let response: NextRacesResponse = try await apiService.request(route: RacingAPI.nextRaces(limit: raceLimitToFetch))
            fetchedRaces = response.toRaces()
            startTimer()
        } catch {
            errorAlert = .init(from: error)
        }
        isLoading = false
    }

    // MARK: - Private

    private func startTimer() {
        guard timerSubscription == nil else { return }
        timerSubscription = autoplayTimer
            .sink { [weak self] _ in
                guard let self else { return }
                withAnimation {
                    self.date = Date()
                }
                fetchNewRacesIfNeeded()
            }
    }

    private func fetchNewRacesIfNeeded() {
        guard shouldFetchNewData else { return }
        Task {
            await fetchNextRaces()
        }
    }
}
