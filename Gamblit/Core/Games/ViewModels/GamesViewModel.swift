//
//  GamesViewModel.swift
//  Gamblit
//
//  Created by Jack Anderson on 12/22/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@MainActor
final class GamesViewModel: ObservableObject {
    
    @Published var games: [Game]? = []
    @Published var historicalGame: [Historical]? = []
    @Published var historicalDetailedDataPoints: [DetailedDataPoint]? = []
    @Published var gameAverages: [String: (Double?, Double?, Double?, Double?, Double?, Double?)]? = [:]
    @Published var selectedSport: Sport? {
        didSet {
            selectedLeague = selectedSport?.leagues.first?.apiIdentifier
        }
    }
    @Published var selectedLeague: String?
    @Published var selectedMarkets: [Markets]?
    @Published var selectedBooks: [String]?
    @Published var selectedDate: String?
    @Published var selectedFilter: apiFilter = .sports
    @Published var selectedGame: Game?
    
    var gamesManager: GamesManager
    
    var url: URL {
        let baseURL = "https://us-central1-gamblit-47419.cloudfunctions.net/main"
        
        switch selectedFilter {
        case .sports:
            return URL(string: "\(baseURL)/sports?league=\(selectedLeague ?? "americanfootball_nfl")&markets=\(selectedMarkets?.compactMap { $0.key }.joined(separator: ",") ?? "h2h,totals,spreads")&bookmakers=\(selectedBooks?.compactMap { $0 }.joined(separator: ",") ?? "draftkings")")!
        case .event:
            return  URL(string: "\(baseURL)/event?league=\(selectedLeague ?? "americanfootball_nfl")&event_id=\(selectedGame?.id ?? "")&markets=\(selectedMarkets?.compactMap { $0.key }.joined(separator: ",") ?? "h2h,totals,spreads")&regions=us")!
        case .historical:
            return URL(string: "\(baseURL)/historical?league=\(selectedLeague ?? "americanfootball_nfl")&markets=\(selectedMarkets?.compactMap { $0.key }.joined(separator: ",") ?? "h2h,totals,spreads")&bookmakers=\(selectedBooks?.compactMap { $0 }.joined(separator: ",") ?? "draftkings")&date=\(selectedDate ?? ISO8601DateFormatter().string(from: Date()))")!
        }
    }
    
    init(_ gamesManager: GamesManager) {
        self.gamesManager = gamesManager
        getGames()
        getAverages()
        getHistoricalGame()
    }
    
    private func getGames() {
        Task {
            for await game in gamesManager.$games.values {
                await MainActor.run(body: {
                    self.games = game
                })
            }
        }
    }
    
    private func getHistoricalGame() {
        Task {
            for await historical in gamesManager.$historicalGame.values {
                await MainActor.run(body: {
                    self.historicalGame = historical
                })
            }
        }
    }
    
    private func getAverages() {
        Task {
            for await average in gamesManager.$gameAverages.values {
                await MainActor.run {
                    self.gameAverages = average
                }
            }
        }
    }
    
    func start() async {
        do {
            let token = try await fetchFirebaseAuthToken()
            
            if selectedFilter == .historical, let startDateString = selectedDate, let startDate = convertToDate(from: startDateString) {
                let dates = generateDateRange(from: startDate)
                for date in dates {
                    let dateString = ISO8601DateFormatter().string(from: date)
                    let historicalURL = createHistoricalURL(for: dateString)
                    try await gamesManager.fetchGamesFromURL(url: historicalURL, token: token, apiFilter: .historical)
                }
            } else {
                try await gamesManager.fetchGamesFromURL(url: self.url, token: token, apiFilter: selectedFilter)
            }
            gamesManager.calculateAverages()
        } catch {
            print(error.localizedDescription)
        }
    }

    
    private func fetchFirebaseAuthToken() async throws -> String {
        guard let credential = try await Auth.auth().currentUser?.getIDToken()
        else {
            throw URLError(.badServerResponse)
        }
        return credential
    }
    
    func refreshData() async {
        await start()
        getGames()
        getAverages()
        getHistoricalGame()
    }
    
    func convertToDate(from dateString: String) -> Date? {
        let dateFormatter = ISO8601DateFormatter()
        return dateFormatter.date(from: dateString)
    }

    private func generateDateRange(from startDate: Date, to endDate: Date = Date()) -> [Date] {
        var dates: [Date] = []
        var currentDate = startDate

        let calendar = Calendar.current
        while currentDate <= endDate {
            dates.append(currentDate)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }

        return dates
    }
    
    func fetchHistoricalData(startingFrom startDate: Date) async {
        let dates = generateDateRange(from: startDate)
        for date in dates {
            let dateString = ISO8601DateFormatter().string(from: date)
            let historicalURL = createHistoricalURL(for: dateString)
            try? await gamesManager.fetchGamesFromURL(url: historicalURL, token: try? await fetchFirebaseAuthToken(), apiFilter: .historical)
        }
    }

    private func createHistoricalURL(for date: String) -> URL {
        let baseURL = "https://us-central1-gamblit-47419.cloudfunctions.net/main"
        return URL(string: "\(baseURL)/historical?league=\(selectedLeague ?? "americanfootball_nfl")&markets=\(selectedMarkets?.compactMap { $0.key }.joined(separator: ",") ?? "h2h,totals,spreads")&bookmakers=\(selectedBooks?.compactMap { $0 }.joined(separator: ",") ?? "draftkings")&date=\(date)")!
    }
    
    func filterHistorical(gameID: String) async {
        // Convert timestamp string to Date
        let dateFormatter = ISO8601DateFormatter()
        
        historicalGame?.forEach { historicalGame in
            if let dateString = historicalGame.timestamp, let date = dateFormatter.date(from: dateString) {
                historicalGame.games.forEach { game in
                    if game.id == gameID {
                        game.bookmakers?.forEach { bookmaker in
                            bookmaker.markets?.forEach { market in
                                market.outcomes?.forEach { outcome in
                                    if let price = outcome.price {
                                        let dataPoint = DetailedDataPoint(
                                            id: UUID(),
                                            date: date,
                                            value: price,
                                            book: bookmaker.title ?? "Unknown",
                                            marketKey: market.key ?? "Unknown",
                                            outcomeName: outcome.name ?? "Unknown",
                                            outcomePrice: outcome.price ?? 0.0,
                                            outcomePoint: outcome.point
                                        )
                                        historicalDetailedDataPoints?.append(dataPoint)
                                        print(dataPoint)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
