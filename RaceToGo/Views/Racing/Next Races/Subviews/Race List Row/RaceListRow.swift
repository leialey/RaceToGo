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
            raceNumberView
            Divider()
            Text(viewModel.meetingName)
            Spacer()
            timeLeftView
        }
        .animation(nil, value: viewModel.startsInString)
        .accessibilityElement(children: .combine)
    }

    // MARK: - Subviews

    private var raceNumberView: some View {
        VStack {
            Text(viewModel.categoryEmoji)
                .accessibilityLabel(viewModel.categoryName)
            Text(viewModel.raceNumber)
        }
        .fontWeight(.medium)
        .frame(maxWidth: 40)
    }

    private var timeLeftView: some View {
        Text(viewModel.startsInString)
            .foregroundStyle(Color.red)
            .font(.caption.weight(.medium))
            .accessibilityLabel(viewModel.startsInA11yLabel)
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

