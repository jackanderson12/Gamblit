import SwiftUI

struct GameDetailView: View {
    
    @StateObject var viewModel: GamesViewModel
    @StateObject var profileViewModel: ProfileViewModel
    
    var game: Game
    @State private var books: [Bookmakers]? = []
    @State private var bookmakers: [(String, Bool)] = []
    @State private var isAverage: Bool = true
    
    @State private var isSelectingBooks = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            if viewModel.selectedFilter != .historical {
                BookmakersButtonsView(viewModel: viewModel, profileViewModel: profileViewModel, bookmakers: $bookmakers, isAverage: $isAverage)
            }
            GameChartPickerView(selectedFilter: $viewModel.selectedFilter)
        }
        VStack {
            switch viewModel.selectedFilter {
            case .sports:
                if let gameId = game.id, let gameAverage = viewModel.gameAverages?[gameId] {
                    GameCardView(viewModel: viewModel, profileViewModel: profileViewModel, game: game, gameAverage: gameAverage)
                        .frame(width: 355, height: 200)
                }
            case .event:
                EventView(viewModel: viewModel, profileViewModel: profileViewModel, game: game, books: $books, isSelectingBooks: $isSelectingBooks)
            case .historical:
                HistoricalView(viewModel: viewModel, profileViewModel: profileViewModel, game: game)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink("New Gamble") {
                    CreateGambleRemodelView(game: game, bookmakers: books ?? [])
                }
            }
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    isSelectingBooks.toggle()
                }) {
                    Text(isSelectingBooks ? "Done" : "Select Books")
                }
            }
        }
        .onAppear {
            viewModel.selectedGame = game
            Task {
                await viewModel.refreshData()
            }
        }
        .task {
            try? await profileViewModel.loadCurrentUser()
            for book in profileViewModel.user?.sportsBooks ?? [] {
                bookmakers.append((book, false))
            }
        }
        .onDisappear {
            Task {
                viewModel.selectedFilter = .sports
                await viewModel.refreshData()
            }
        }
    }
}
