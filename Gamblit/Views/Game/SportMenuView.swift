//
//  SportMenuView.swift
//  Gamblit
//
//  Created by Jack Anderson on 12/22/23.
//

import SwiftUI

struct SportMenuView: View {
    @StateObject private var viewModel = GamesViewModel(GamesManager())
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            ForEach(Sport.allCases, id: \.self) { sport in
                NavigationLink {
                    DelayedGamesView(viewModel: viewModel)
                } label: {
                    Text(sport.rawValue)
                }
                .simultaneousGesture(TapGesture().onEnded {
                    viewModel.selectedSport = sport
                })
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

struct DelayedGamesView: View {
    
    @StateObject var viewModel: GamesViewModel
    @State private var isLoading: Bool = true
    
    var body: some View {
        ZStack {
            if isLoading {
                ProgressView()
            } else {
                GamesView(viewModel: viewModel)
            }
        }
        .task(priority: .high) {
            await viewModel.refreshData()
            isLoading = false
        }
    }
}
