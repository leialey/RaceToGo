//
//  CategoryFilterViewModel.swift
//  RaceToGo
//
//  Created by Ekaterina Rodionova on 2/8/2024.
//

import Foundation

struct CategoryFilterViewModel: Identifiable, Equatable {
    let category: RaceCategory
    var isOn: Bool

    var id: RaceCategory {
        category
    }
}
