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
    @Binding var books: [Bookmakers]?
    @Binding var bookmakers: [(String, Bool)]
    @Binding var isSelectingBooks: Bool
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 15) {
                if let gameId = game.id, let gameAverage = viewModel.gameAverages?[gameId] {
                    GameCardView(viewModel: viewModel, profileViewModel: profileViewModel, game: game, gameAverage: gameAverage)
                        .frame(width: 355, height: 200)
                }
                
                ForEach(game.bookmakers ?? [], id: \.key) { book in
                    BookmakerView(book: book, game: game, isSelected: books?.contains(where: { $0.key == book.key }) ?? false) {
                        toggleBookSelection(book: book)
                    }
                }
            }
        }
        .onChange(of: viewModel.selectedBooks) {
            Task {
                await viewModel.refreshData()
            }
        }
        .onAppear {
            filterBooks(game: game, bookmakers: bookmakers)
        }
        .task {
            await viewModel.refreshData()
        }
    }
    
    private func toggleBookSelection(book: Bookmakers) {
        guard var currentBooks = books else {
            books = [book]
            return
        }
        
        if let index = currentBooks.firstIndex(where: { $0.key == book.key }) {
            currentBooks.remove(at: index)
        } else {
            currentBooks.append(book)
        }
        
        books = currentBooks
    }
    
    //Not functioning, would like to include this to filter by the users
    //selected books
    private func filterBooks(game: Game, bookmakers: [(String, Bool)]) {
        for book in game.bookmakers! {
            if bookmakers.contains(where: { $0.0 == book.key }) {
                books?.append(book)
            }
        }
    }
}

#Preview {
    EventView(viewModel: GamesViewModel(GamesManager()), profileViewModel: ProfileViewModel(), game: Game(id: "", commenceTime: "", homeTeam: "", awayTeam: "", sportKey: "", sportTitle: "", bookmakers: []), books: DeveloperPreview.shared.bindingBooks, bookmakers: DeveloperPreview.shared.bindingBookmakers, isSelectingBooks: .constant(false))
}

