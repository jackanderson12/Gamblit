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
                    if let bookKey = book.key,
                       bookmakers.contains(where: { $0.0.lowercased() == bookKey.lowercased() && $0.1 }) {
                        BookmakerView(book: book,
                                      game: game,
                                      isSelected: books?.contains(where: { $0.key == book.key }) ?? false) {
                            toggleBookSelection(book: book)
                        }
                    }
                }
            }
        }
        .onChange(of: viewModel.selectedBooks) {
            Task {
                await viewModel.refreshData()
            }
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
}

#Preview {
    EventView(viewModel: GamesViewModel(GamesManager()), profileViewModel: ProfileViewModel(), game: Game(id: "", commenceTime: "", homeTeam: "", awayTeam: "", sportKey: "", sportTitle: "", bookmakers: []), books: DeveloperPreview.shared.bindingBooks, bookmakers: DeveloperPreview.shared.bindingBookmakers, isSelectingBooks: .constant(false))
}

