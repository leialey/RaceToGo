//
//  RaceListRow.swift
//  RaceToGo
//
//  Created by Ekaterina Rodionova on 31/7/2024.
//

import SwiftUI

struct RaceListRow: View {
    let viewModel: RaceViewModel

    var body: some View {
        Label(
            title: {
                HStack {
                    Text(viewModel.raceNumber)
                    Text(viewModel.meetingName)
                    Spacer()
                    Text(viewModel.timeLeftString)
                        .foregroundStyle(Color.red)
                        .font(.caption.weight(.medium))
                }
            },
            icon: {
                Text(viewModel.categoryEmoji)
            }
        )
        .animation(nil, value: viewModel.timeLeftString)
    }
}

//#Preview {
//    RaceListRow(
//        viewModel: .init(race: Race, date: )
//    )
//}

