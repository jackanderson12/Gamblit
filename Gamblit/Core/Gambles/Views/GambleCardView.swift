//
//  GambleCardView.swift
//  Gamblit
//
//  Created by Jack Anderson on 12/12/23.
//

import SwiftUI
import Charts

struct GambleCardView: View {
    let game: Game
    let selectedBook: [Bookmakers]
    
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
                .frame(width: 100)
                Spacer()
                HStack {
                    VStack(alignment: .center, spacing: 2) {
                        Text("H2H")
                            .font(.headline)
                        Text("\(gameAverage.0 ?? 0, specifier: "%.1f")")
                        Text("\(gameAverage.1 ?? 0, specifier: "%.1f")")
                    }
                    VStack(alignment: .center, spacing: 2) {
                        Text("Total")
                            .font(.headline)
                        Text("\(gameAverage.2 ?? 0, specifier: "%.1f")")
                        Text("\(gameAverage.3 ?? 0, specifier: "%.1f")")
                    }
                    VStack(alignment: .center, spacing: 2) {
                        Text("Spread")
                            .font(.headline)
                        Text("\(gameAverage.4 ?? 0, specifier: "%.1f")")
                        Text("\(gameAverage.5 ?? 0, specifier: "%.1f")")
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    GambleCardView(game: DeveloperPreview.shared.game, selectedBook: DeveloperPreview.shared.bookmakers)
}
