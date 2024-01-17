//
//  GamesView.swift
//  Gamblit
//
//  Created by Jack Anderson on 12/22/23.
//

import SwiftUI

struct GamesView: View {
    
    @StateObject var viewModel: GamesViewModel
    @State private var leagues: [League] = []
    @State private var searchGames: String = ""
    
    var body: some View {
        ZStack {
            VStack {
                TextField("Search Games", text: $searchGames)
                    .padding()
                HStack {
                    ForEach(leagues, id: \.apiIdentifier) { league in
                        Button(action: {
                            viewModel.selectedLeague = league.apiIdentifier
                            Task {
                                await viewModel.refreshData()
                            }
                        }, label: {
                            Text(league.displayName)
                        })
                        .buttonStyle(.borderedProminent)
                        .opacity(league.apiIdentifier == viewModel.selectedLeague ? 1.0 : 0.5)
                    }
                }
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.games ?? [], id: \.self) { game in
                            if let gameId = game.id, let gameAverage = viewModel.gameAverages?[gameId] {
                                GameCardView(viewModel: viewModel, game: game, gameAverage: gameAverage)
                                    .frame(width: 355, height: 200)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle("Games View")
        .onAppear {
            leagues = viewModel.selectedSport?.leagues ?? Sport.football.leagues
        }
        .task {
            await viewModel.start()
        }
    }
}


#Preview {
    GamesView(viewModel: GamesViewModel(GamesManager()))
}
