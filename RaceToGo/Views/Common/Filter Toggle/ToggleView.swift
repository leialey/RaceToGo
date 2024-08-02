//
//  ToggleView.swift
//  RaceToGo
//
//  Created by Ekaterina Rodionova on 2/8/2024.
//

import SwiftUI

struct ToggleView: View {
    @Binding var isOn: Bool
    let title: String
    let emoji: String
    
    var body: some View {
        Toggle(isOn: $isOn, label: {
            Label(
                title: {
                    Text(title)
                },
                icon: {
                    Text(emoji)
                }
            )
        })
        .accessibilityRemoveTraits(.isButton)
    }
}

#Preview {
    ToggleView(isOn: .constant(true), title: "Category", emoji: "😁")
}
