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
    
    @State private var selectedSport: Sport = .football
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 20) {
                ForEach(Sport.allCases, id: \.self) { sport in
                    NavigationLink {
                        DelayedGamesView(viewModel: viewModel, profileViewModel: profileViewModel)
                    } label: {
                        Text(sport.rawValue)
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        selectedSport = sport
                    })
                    .buttonStyle(.borderedProminent)
                }
            }
            .onChange(of: selectedSport) {
                viewModel.selectedSport = selectedSport
            }
            .task {
                try? await profileViewModel.loadCurrentUser()
                viewModel.selectedBooks = profileViewModel.user?.sportsBooks
            }
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
