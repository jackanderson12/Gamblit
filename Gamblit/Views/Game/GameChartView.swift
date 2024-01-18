//
//  GameChartView.swift
//  Gamblit
//
//  Created by Jack Anderson on 1/4/24.
//

import SwiftUI

struct GameChartView: View {
    @StateObject var viewModel: GamesViewModel
    
    var game: Game
    
    @State private var h2hAverage: [(Date, Double)?] = []
    @State private var totalAverage: [(Date, Double)?] = []
    @State private var spreadAverage: [(Date, Double)?] = []
    
    let timer = Timer.publish(every: 15, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 15) {
                Text("H2H")
                    .font(.headline)
                ChartView(coordinates: h2hAverage)
                
                Text("Total")
                    .font(.headline)
                ChartView(coordinates: totalAverage)
                
                Text("Spread")
                    .font(.headline)
                ChartView(coordinates: spreadAverage)
                
            }
            .onReceive(timer) { _ in
                let now = Date() // Update the current time
                if let h2hAvg = viewModel.gameAverages?[game.id ?? ""]?.0 {
                    h2hAverage.append((now, h2hAvg))
                }
                if let totalAvg = viewModel.gameAverages?[game.id ?? ""]?.2 {
                    totalAverage.append((now, totalAvg))
                }
                if let spreadAvg = viewModel.gameAverages?[game.id ?? ""]?.4 {
                    spreadAverage.append((now, spreadAvg))
                }
            }
        }
        .navigationTitle((game.homeTeam ?? "Home Team") + " vs. " +  (game.awayTeam ?? "Away Team"))
    }
}


//#Preview {
//    GameChartView(viewModel: GamesViewModel(GamesManager()), game: Game(id: "", commenceTime: "01/01/24 8:00PM EST", homeTeam: "Home Team", awayTeam: "Away Team", sportKey: "americanfootball_nfl", sportTitle: "NFL", bookmakers: []))
//}