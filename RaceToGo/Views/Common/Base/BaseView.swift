//
//  BaseView.swift
//  RaceToGo
//
//  Created by Ekaterina Rodionova on 31/7/2024.
//

import SwiftUI

// View that holds the common logic between all main views
struct BaseView<Content: View, ViewModel: BaseViewModelProtocol>: View {
    @StateObject var viewModel: ViewModel
    @ViewBuilder let content: Content

    var body: some View {
        content
            .alert(item: $viewModel.errorAlert) { errorAlert in
                    .init(
                        title: Text(errorAlert.title),
                        message: Text(errorAlert.description)
                    )
            }
    }
}
