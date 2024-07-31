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

    private let raceLimit = 5
    private let raceLimitToFetch = 10
    let title = String(localized: "Next to go racing")

    // MARK: - Variables

    @Published private var nextRaces: [Race] = []
    @Published var selectedCategories: [RaceCategory] = []

    private lazy var autoplayTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private var timerSubscription: AnyCancellable?

    var raceViewModels: [RaceViewModel] {
        filteredRaces.map { .init(race: $0, date: date) }
    }

    var filteredRaces: [Race] {
        Array(
            nextRaces
                .filter({ date.distance(to: $0.advertisedStart) > -60 })
                .sorted(by: { $0.advertisedStart < $1.advertisedStart })
                .prefix(raceLimit)
        )
    }

    var allCategories: [RaceCategory] {
        RaceCategory.allCases
    }

    // MARK: - Dependencies

    private let apiService: APIServiceProtocol
    @Published private var date: Date

    // MARK: - Lifecycle

    init(apiService: APIServiceProtocol, date: Date = Date()) {
        self.apiService = apiService
        self.date = date
    }

    // MARK: - Public methods

    @MainActor
    func fetchNextRaces() async {
        isLoading = true
        do {
            let response: NextRacesResponse = try await apiService.request(route: RacingAPI.nextRaces(limit: raceLimitToFetch))
            nextRaces = response.toRaces()
            startTimer()
        } catch {
            errorAlert = .init(from: error)
        }
        isLoading = false
    }

    private func startTimer() {
        timerSubscription = autoplayTimer
            .sink { [weak self] _ in
                withAnimation {
                    self?.date = Date()
                }
            }
    }
}
