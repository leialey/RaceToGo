//
//  EmptyListView.swift
//  RaceToGo
//
//  Created by Ekaterina Rodionova on 2/8/2024.
//

import SwiftUI

// Used to display an overlay for a list with no data
struct EmptyListView: View {
    let viewModel: EmptyListViewModel

    var body: some View {
        VStack {
            Image(systemName: "questionmark.circle")
                .font(.title)
                .padding(.bottom, 8)
                .accessibilityHidden(true)

            Text(viewModel.title)

            if let subtitle = viewModel.subtitle {
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .opaqueIfTrue(viewModel.condition)
    }
}

#Preview {
    EmptyListView(viewModel: .init(title: "Oops", subtitle: "There is no data", condition: true))
}
