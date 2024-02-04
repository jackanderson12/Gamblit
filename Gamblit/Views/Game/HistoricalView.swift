//
//  HistoricalView.swift
//  Gamblit
//
//  Created by Jack Anderson on 1/24/24.
//

import SwiftUI

struct HistoricalView: View {
    
    @StateObject var viewModel: GamesViewModel
    @StateObject var profileViewModel: ProfileViewModel
    
    var game: Game
    
    @State private var selectedDate: Date = Date()
    @State private var historicalData: [String: (String, Date, Double?, Double?)]? = [:]
    
    var body: some View {
        VStack(spacing: 15) {
            HistoricalPickerView(selectedDate: $selectedDate)
            GameChartView(viewModel: viewModel, profileViewModel: profileViewModel, game: game)
        }
        .onChange(of: selectedDate) {
            viewModel.selectedDate = ISO8601DateFormatter().string(from: selectedDate)
            Task {
                await viewModel.refreshData()
            }
        }
        .onAppear {
            viewModel.filterHistorical(gameID: game.id ?? "")
            historicalData = viewModel.convertedHistorical
        }
    }
}

#Preview {
    HistoricalView(viewModel: GamesViewModel(GamesManager()), profileViewModel: ProfileViewModel(), game: Game(id: "", commenceTime: "", homeTeam: "", awayTeam: "", sportKey: "", sportTitle: "", bookmakers: []))
}
