//
//  GamesView.swift
//  Gamblit
//
//  Created by Jack Anderson on 12/22/23.
//

import SwiftUI

struct GamesView: View {
    
    @StateObject var viewModel = GamesViewModel(GamesManager())
    @State var sport = "Football"
    @State private var leagues: [String] = []
    @State private var searchGames: String = ""
    @State private var openSportMenu: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                TextField("Search Games", text: $searchGames)
                    .padding()
                HStack {
                    ForEach(leagues, id: \.self) { league in
                        Button(action: {
                            // Action for when a league button is tapped
                        }, label: {
                            Text(league)
                        })
                        .buttonStyle(.borderedProminent)
                    }
                }
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.games ?? [], id: \.self) { game in
                            // safely unwrap game.id and gameAverages
                            if let gameId = game.id, let gameAverage = viewModel.gameAverages?[gameId] {
                                GameCardView(game: game, gameAverage: gameAverage)
                                    .frame(width: 355, height: 200)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            if openSportMenu {
                SportMenuView() // Assuming SportMenuView is defined somewhere
            }
        }
        .navigationTitle("Games View")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    openSportMenu.toggle()
                }, label: {
                    Image(systemName: "line.3.horizontal")
                })
            }
        }
        .onAppear {
            leagues = viewModel.selectedSport.leagues // Ensure this is safely accessed
        }
        .task {
            await viewModel.start()
        }
    }
}


#Preview {
    GamesView()
}
