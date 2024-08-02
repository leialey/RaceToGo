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
        HStack(spacing: 12) {
            VStack {
                Text(viewModel.categoryEmoji)
                    .accessibilityLabel(viewModel.categoryName)
                Text(viewModel.raceNumber)
            }
            .fontWeight(.medium)
            .frame(maxWidth: 40)

            Divider()

            Text(viewModel.meetingName)

            Spacer()

            Text(viewModel.timeLeftString)
                .foregroundStyle(Color.red)
                .font(.caption.weight(.medium))
                .accessibilityLabel(viewModel.timeLeftA11yLabel)
        }
        .animation(nil, value: viewModel.timeLeftString)
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    List {
        RaceListRow(
            viewModel: .init(
                race: .init(
                    id: "123", number: 100,
                    name: "Race name",
                    category: .horse, meetingName: "A very long name to check layout",
                    advertisedStart: Date().addingTimeInterval(99999999)
                ),
                date: Date()
            )
        )
    }
}

