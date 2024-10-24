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
    @State private var historicalDetailedDataPoints: [DetailedDataPoint]? = []
    @State private var isDatePickerVisible: Bool = true
    
    var body: some View {
        VStack(spacing: 15) {
            HistoricalChartView(viewModel: viewModel, profileViewModel: profileViewModel, game: game, historicalDetailedDataPoints: $historicalDetailedDataPoints)
        }
        .padding(.horizontal)
        .sheet(isPresented: $isDatePickerVisible, content: {
            HistoricalPickerView(selectedDate: $selectedDate)
                .presentationDetents([.medium, .large])
        })
        .onChange(of: selectedDate) {
            viewModel.selectedDate = ISO8601DateFormatter().string(from: selectedDate)
            Task {
                viewModel.historicalDetailedDataPoints = []
                await viewModel.refreshData()
                await viewModel.filterHistorical(gameID: game.id ?? "")
                historicalDetailedDataPoints = viewModel.historicalDetailedDataPoints
            }
        }
        .task {
            print(game.id ?? "No game ID")
            await viewModel.refreshData()
            await viewModel.filterHistorical(gameID: game.id ?? "")
            historicalDetailedDataPoints = viewModel.historicalDetailedDataPoints
        }
    }
}

#Preview {
    HistoricalView(viewModel: GamesViewModel(GamesManager()), profileViewModel: ProfileViewModel(), game: Game(id: "", commenceTime: "", homeTeam: "", awayTeam: "", sportKey: "", sportTitle: "", bookmakers: []))
}
