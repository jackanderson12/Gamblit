//
//  GameChartView.swift
//  Gamblit
//
//  Created by Jack Anderson on 1/4/24.
//

import SwiftUI
import Charts

struct GameChartView: View {
    
    @StateObject var viewModel: GamesViewModel
    var game: Game
    
    var body: some View {
        Chart {
//            PointMark(
//                x: ,
//                y:
//            )
//            .chartYScale(range: 100...)
//            .frame(width: 350, height: 225)
        }
        .navigationTitle((game.homeTeam ?? "Home Team") + " vs. " +  (game.awayTeam ?? "Away Team"))
    }
}

#Preview {
    GameChartView(viewModel: GamesViewModel(GamesManager()), game: Game(id: "", commenceTime: "01/01/24 8:00PM EST", homeTeam: "Home Team", awayTeam: "Away Team", sportKey: "americanfootball_nfl", sportTitle: "NFL", bookmakers: []))
}
