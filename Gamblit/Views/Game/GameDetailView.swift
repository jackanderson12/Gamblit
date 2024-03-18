//
//  GameDetailView.swift
//  Gamblit
//
//  Created by Jack Anderson on 1/20/24.
//

import SwiftUI

struct GameDetailView: View {
    
    @StateObject var viewModel: GamesViewModel
    @StateObject var profileViewModel: ProfileViewModel
    
    var game: Game
    @State private var bookmakers: [(String, Bool)] = []
    @State private var isAverage: Bool = true
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            if viewModel.selectedFilter != .historical {
                BookmakersButtonsView(viewModel: viewModel, profileViewModel: profileViewModel, bookmakers: $bookmakers, isAverage: $isAverage)
            }
            GameChartPickerView(selectedFilter: $viewModel.selectedFilter)
        }
        VStack {
            switch viewModel.selectedFilter {
            case .sports:
                if let gameId = game.id, let gameAverage = viewModel.gameAverages?[gameId] {
                    GameCardView(viewModel: viewModel, profileViewModel: profileViewModel, game: game, gameAverage: gameAverage)
                        .frame(width: 355, height: 200)
                }
            case .event:
                EventView(viewModel: viewModel, game: game)
            case .historical:
                HistoricalView(viewModel: viewModel, profileViewModel: profileViewModel, game: game)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink("New Gamble") {
                    CreateGambleView(profileViewModel: profileViewModel, game: game)
                }
            }
        }
        .onChange(of: viewModel.selectedFilter) {
            Task {
                viewModel.eventId = game.id
                await viewModel.refreshData()
            }
        }
        .task {
            try? await profileViewModel.loadCurrentUser()
            for book in profileViewModel.user?.sportsBooks ?? [] {
                bookmakers.append((book, false))
            }
        }
        .onDisappear {
            Task {
                viewModel.selectedFilter = .sports
                await viewModel.refreshData()
            }
        }
    }
}

#Preview {
    GameDetailView(viewModel: GamesViewModel(GamesManager()), profileViewModel: ProfileViewModel(), game: Game(id: "", commenceTime: "", homeTeam: "", awayTeam: "", sportKey: "", sportTitle: "", bookmakers: []))
}
