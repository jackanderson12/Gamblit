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
    @State private var userId: String? = ""
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            BookmakersButtonsView(viewModel: viewModel, bookmakers: game.bookmakers?.compactMap { $0.title } ?? [])
            GameChartPickerView(viewModel: viewModel)
        }
        VStack {
            switch pickerValue {
            case .sports:
                GameChartView(viewModel: viewModel, profileViewModel: profileViewModel, game: game)
            case .event: Text("Event")
            case .historical: Text("Historical")
            default: Text("Default")
            }
        }
        .onAppear {
            pickerValue = viewModel.selectedFilter
        }
    }
}

#Preview {
    GameDetailView(viewModel: GamesViewModel(GamesManager()), profileViewModel: ProfileViewModel(), game: Game(id: "", commenceTime: "", homeTeam: "", awayTeam: "", sportKey: "", sportTitle: "", bookmakers: []))
}
