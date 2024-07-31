//
//  CustomError.swift
//  RaceToGo
//
//  Created by Ekaterina Rodionova on 31/7/2024.
//

import Foundation

protocol CustomError: LocalizedError {
    var userFacingError: String { get }
    var developerFacingError: String { get }
}
