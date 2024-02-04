//
//  HistoricalChartView.swift
//  Gamblit
//
//  Created by Jack Anderson on 1/31/24.
//

import SwiftUI
import Charts

struct HistoricalChartView: View {
    
    @StateObject var viewModel: GamesViewModel
    @StateObject var profileViewModel: ProfileViewModel
    
    var game: Game
    
    @State private var historicalData: [String: (String, Date, Double, Double)] = [:]
    
    var body: some View {
        ZStack {
            
        }
    }
}

#Preview {
    HistoricalChartView(viewModel: GamesViewModel(GamesManager()), profileViewModel: ProfileViewModel(), game: Game(id: "", commenceTime: "", homeTeam: "", awayTeam: "", sportKey: "", sportTitle: "", bookmakers: []))
}
