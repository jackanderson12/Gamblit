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
    @Published var gameAverages: [String: (Double?, Double?, Double?, Double?, Double?, Double?)]? = [:]
    @Published var selectedSport: Sport? {
        didSet {
            selectedLeague = selectedSport?.leagues.first?.apiIdentifier
        }
    }
    @Published var selectedLeague: String?
    @Published var selectedMarkets: [Markets]?
    @Published var selectedBooks: [Bookmakers]?
    @Published var selectedDate: String?
    @Published var selectedFilter: apiFilter? = .sports
    @Published var eventId: String?
    
    var gamesManager: GamesManager
    
    let key = "e37ef2b2520c5f2a152db29a1e2267c3"
    
    var url: URL {
        let baseURL = "https://api.the-odds-api.com/v4"
        
        switch selectedFilter {
            
        case .sports:
            return URL(string: "\(baseURL)/sports/\(selectedLeague ?? "americanfootball_nfl")/odds?markets=\(selectedMarkets?.compactMap { $0.key }.joined(separator: ",") ?? "h2h,totals,spreads")&bookmakers=\(selectedBooks?.compactMap { $0.title }.joined(separator: ",") ?? "draftkings")&apiKey=\(key)")!
        case .event:
            return  URL(string: "\(baseURL)/sports/\(selectedLeague ?? "americanfootball_nfl")/events/\(eventId ?? "")/odds?markets=\(selectedMarkets?.compactMap { $0.key }.joined(separator: ",") ?? "h2h,totals,spreads")&apiKey=\(key)")!
        case .historical:
            return URL(string: "\(baseURL)/historical/sports/\(selectedLeague ?? "americanfootball_nfl")/odds?markets=\(selectedMarkets?.compactMap { $0.key }.joined(separator: ",") ?? "h2h,totals,spreads")&date=\(selectedDate ?? ISO8601DateFormatter().string(from: Date()))&apiKey=\(key)")!
        default:
            return URL(string: "\(baseURL)/sports/\(selectedLeague ?? "americanfootball_nfl")/odds?markets=\(selectedMarkets?.compactMap { $0.key }.joined(separator: ",") ?? "h2h,totals,spreads")&apiKey=\(key)")!
        }
    }
    
    init(_ gamesManager: GamesManager) {
        self.gamesManager = gamesManager
        getGames()
        getAverages()
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
            try await gamesManager.fetchGamesFromURL(url: self.url, token: token, apiFilter: selectedFilter ?? .sports)
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
    }
    
}
