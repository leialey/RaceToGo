//
//  ViewModifiers.swift
//  RaceToGo
//
//  Created by Ekaterina Rodionova on 2/8/2024.
//

import SwiftUI

// instead of .opaque(bool ? 1 : 0), simply use .opaqueIfTrue(bool)
struct OpaqueIfTrueModifier: ViewModifier {
    let condition: Bool

    func body(content: Content) -> some View {
        content
            .opacity(condition ? 1 : 0)
    }
}

extension View {
    func opaqueIfTrue(_ condition: Bool) -> some View {
        self.modifier(OpaqueIfTrueModifier(condition: condition))
    }
}
