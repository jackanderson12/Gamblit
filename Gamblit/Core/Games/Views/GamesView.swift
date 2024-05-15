//
//  GamesView.swift
//  Gamblit
//
//  Created by Jack Anderson on 12/22/23.
//

import SwiftUI

struct GamesView: View {
    
    @StateObject var viewModel: GamesViewModel
    @StateObject var profileViewModel: ProfileViewModel
    
    @State private var leagues: [League] = []
    @State private var searchGames: String = ""
    
    private var filteredGames: [Game] {
        guard !searchGames.isEmpty else { return viewModel.games ?? [] }
        return viewModel.games?.filter { game in
            game.homeTeam?.lowercased().contains(searchGames.lowercased()) == true ||
            game.awayTeam?.lowercased().contains(searchGames.lowercased()) == true
        } ?? []
    }
    
    var body: some View {
        ZStack {
            VStack {
                TextField("Search Games", text: $searchGames)
                    .padding()
                ScrollView(.horizontal, showsIndicators: false) {
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
                }
                ScrollView {
                    LazyVStack {
                        ForEach(filteredGames, id: \.self) { game in
                            if let gameId = game.id, let gameAverage = viewModel.gameAverages?[gameId] {
                                GameCardView(viewModel: viewModel, profileViewModel: profileViewModel, game: game, gameAverage: gameAverage)
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
    GamesView(viewModel: GamesViewModel(GamesManager()), profileViewModel: ProfileViewModel())
}
