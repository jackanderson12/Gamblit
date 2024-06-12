//
//  EventView.swift
//  Gamblit
//
//  Created by Jack Anderson on 1/24/24.
//

import SwiftUI

struct EventView: View {
    @StateObject var viewModel: GamesViewModel
    @StateObject var profileViewModel: ProfileViewModel
    
    var game: Game
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 15) {
                if let gameId = game.id, let gameAverage = viewModel.gameAverages?[gameId] {
                    GameCardView(viewModel: viewModel, profileViewModel: profileViewModel, game: game, gameAverage: gameAverage)
                        .frame(width: 355, height: 200)
                }
                
                ForEach(game.bookmakers ?? [], id: \.key) { book in
                    VStack {
                        Text("\(book.title?.capitalized ?? "Book Name")")
                            .font(.headline)
                            .fontWeight(.black)
                            .padding(.vertical, 10)
                        EventCardView(game: game, bookmaker: book)
                    }
                }
            }
        }
    }
}

#Preview {
    EventView(viewModel: GamesViewModel(GamesManager()), profileViewModel: ProfileViewModel(), game: Game(id: "", commenceTime: "", homeTeam: "", awayTeam: "", sportKey: "", sportTitle: "", bookmakers: []))
}
