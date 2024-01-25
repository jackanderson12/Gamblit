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
    
    @State private var pickerValue: apiFilter?
    @State private var bookmakers: [(String, Bool)] = []
    @State private var isAverage: Bool = true
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            BookmakersButtonsView(viewModel: viewModel, profileViewModel: profileViewModel, bookmakers: $bookmakers, isAverage: $isAverage)
            GameChartPickerView(viewModel: viewModel)
        }
        VStack {
            switch pickerValue {
            case .sports:
                GameChartView(viewModel: viewModel, profileViewModel: profileViewModel, game: game)
            case .event: EventView()
            case .historical: HistoricalView()
            default: GameChartView(viewModel: viewModel, profileViewModel: profileViewModel, game: game)
            }
        }
        .onAppear {
            pickerValue = viewModel.selectedFilter
        }
        .task {
            try? await profileViewModel.loadCurrentUser()
            for book in profileViewModel.user?.sportsBooks ?? [] {
                bookmakers.append((book, false))
            }
        }
    }
}

#Preview {
    GameDetailView(viewModel: GamesViewModel(GamesManager()), profileViewModel: ProfileViewModel(), game: Game(id: "", commenceTime: "", homeTeam: "", awayTeam: "", sportKey: "", sportTitle: "", bookmakers: []))
}
