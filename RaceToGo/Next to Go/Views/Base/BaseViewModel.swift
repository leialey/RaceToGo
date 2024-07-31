//
//  BaseViewModel.swift
//  RaceToGo
//
//  Created by Ekaterina Rodionova on 31/7/2024.
//

import Foundation

protocol BaseViewModelProtocol: ObservableObject {
    var errorAlert: ErrorAlert? { get set }
    var isLoading: Bool { get set }
}

// Holds all the common logic between view models
class BaseViewModel: BaseViewModelProtocol {
    @Published var errorAlert: ErrorAlert?
    @Published var isLoading = false
}
