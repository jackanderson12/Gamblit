//
//  GambleCardComponent.swift
//  Gamblit
//
//  Created by Jack Anderson on 5/16/24.
//

import SwiftUI

struct GambleCardComponentView: View {
    
    let game: Game
    let bookmaker: Bookmakers

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
                    ForEach(bookmaker.markets ?? [], id: \.self) { market in
                        switch market.key {
                        case "h2h":
                            VStack(alignment: .center, spacing: 2) {
                                Text("H2H")
                                    .font(.headline)
                                Text("\(market.outcomes?[0].price ?? 0, specifier: "%.2f")")
                                Text("\(market.outcomes?[1].price ?? 0, specifier: "%.2f")")
                            }
                        case "totals":
                            VStack(alignment: .center, spacing: 2) {
                                Text("Total")
                                    .font(.headline)
                                HStack {
                                    Text("\(market.outcomes?[0].point ?? 0, specifier: "%.1f")")
                                    VStack{
                                        Text("\(market.outcomes?[0].price ?? 0, specifier: "%.2f")")
                                        Text("\(market.outcomes?[1].price ?? 0, specifier: "%.2f")")
                                    }
                                }
                            }
                        case "spreads":
                            VStack(alignment: .center, spacing: 2) {
                                Text("Spread")
                                    .font(.headline)
                                VStack {
                                    Text("\(market.outcomes?[0].point ?? 0, specifier: "%.1f")")
                                    Text("\(market.outcomes?[0].price ?? 0, specifier: "%.2f")")
                                }
                                VStack {
                                    Text("\(market.outcomes?[1].point ?? 0, specifier: "%.1f")")
                                    Text("\(market.outcomes?[1].price ?? 0, specifier: "%.2f")")
                                }
                            }
                        default:
                            Text("No Game Info")
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    GambleCardComponentView(game: DeveloperPreview.shared.game, bookmaker: DeveloperPreview.shared.bookmakers.first!)
}
