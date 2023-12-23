//
//  GamesView.swift
//  Gamblit
//
//  Created by Jack Anderson on 12/22/23.
//

import SwiftUI

struct GamesView: View {
    
    @StateObject private var viewModel = GamesViewModel()
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

                        }, label: {
                            Text("\(league)")
                        })
                        .buttonStyle(.borderedProminent)
                    }
                }
                if let games = viewModel.games {
                    List {
                        ForEach(games, id: \.self) { game in
                            HStack {
                                VStack {
                                    Text(game.homeTeam)
                                    Text(game.awayTeam)
                                }
                                Text(game.startDate)
                            }
                        }
                    }
                }
                
            }
            
            if openSportMenu {
                SportMenuView()
            }
        }
        .navigationTitle("Games View")
        .toolbar {
            ToolbarItem(id: "sportsMenu", placement: .topBarLeading, content: {
                Button(action: {
                    openSportMenu.toggle()
                }, label: {
                    Image(systemName: "line.3.horizontal")
                })
            })
        }
        .onAppear {
            leagues = viewModel.getLeagues(sport: sport)
        }
    }
}

#Preview {
    GamesView()
}
