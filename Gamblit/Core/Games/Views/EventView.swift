//
//  EventView.swift
//  Gamblit
//
//  Created by Jack Anderson on 1/24/24.
//

import SwiftUI

struct EventView: View {
    @StateObject var viewModel: GamesViewModel
    
    var game: Game
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 15) {
                ForEach(game.bookmakers ?? [], id: \.key) { book in
                    VStack {
                        Text("\(book.title?.capitalized ?? "Book Name")")
                            .font(.headline)
                            .fontWeight(.black)
                            .padding(.vertical, 10)
                        EventCardView(book: book)
                    }
                }
            }
        }
    }
}

#Preview {
    EventView(viewModel: GamesViewModel(GamesManager()), game: Game(id: "", commenceTime: "", homeTeam: "", awayTeam: "", sportKey: "", sportTitle: "", bookmakers: []))
}
