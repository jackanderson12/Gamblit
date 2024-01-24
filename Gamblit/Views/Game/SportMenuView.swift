//
//  SportMenuView.swift
//  Gamblit
//
//  Created by Jack Anderson on 12/22/23.
//

import SwiftUI

struct SportMenuView: View {
    
    @StateObject private var viewModel = GamesViewModel(GamesManager())
    @StateObject private var profileViewModel = ProfileViewModel()
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            ForEach(Sport.allCases, id: \.self) { sport in
                NavigationLink {
                    DelayedGamesView(viewModel: viewModel, profileViewModel: profileViewModel)
                } label: {
                    Text(sport.rawValue)
                }
                .simultaneousGesture(TapGesture().onEnded {
                    viewModel.selectedSport = sport
                })
                .buttonStyle(.borderedProminent)
            }
        }
        .task {
            try? await profileViewModel.loadCurrentUser()
            viewModel.selectedBooks = profileViewModel.user?.sportsBooks
        }
    }
}

struct DelayedGamesView: View {
    
    @StateObject var viewModel: GamesViewModel
    @StateObject var profileViewModel: ProfileViewModel
    
    @State private var isLoading: Bool = true
    
    var body: some View {
        ZStack {
            if isLoading {
                ProgressView()
            } else {
                GamesView(viewModel: viewModel, profileViewModel: profileViewModel)
            }
        }
        .task(priority: .high) {
            await viewModel.refreshData()
            isLoading = false
        }
    }
}
