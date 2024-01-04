//
//  GameCardView.swift
//  Gamblit
//
//  Created by Jack Anderson on 1/2/24.
//

import SwiftUI

import SwiftUI

struct GameCardView: View {
    var game: Game
    var gameAverage: (Double?, Double?, Double?)
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                .foregroundStyle(.green)
                .opacity(0.5)
            HStack {
                VStack(alignment: .center, spacing: 5) {
                    Text(game.homeTeam ?? "Home Team")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                    Text("vs.")
                    Text(game.awayTeam ?? "Away Team")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                }
                VStack(alignment: .center, spacing: 3) {
                    // Example: "Avg. Price: 100.0"
                    Text("H2H: \(gameAverage.0 ?? 1, specifier: "%.2f")")
                    Text("Spread: \(gameAverage.1 ?? 1, specifier: "%.2f")")
                    Text("Total: \(gameAverage.2 ?? 1, specifier: "%.2f")")
                }
            }
            .padding(.horizontal)
        }
        .padding(.all)
    }
}

#Preview {
    GameCardView(game: Game(id: "", commenceTime: "01/01/24 8:00PM EST", homeTeam: "Home Team", awayTeam: "Away Team", sportKey: "americanfootball_nfl", sportTitle: "NFL", bookmakers: []))
}
