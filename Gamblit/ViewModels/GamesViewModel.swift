//
//  GamesViewModel.swift
//  Gamblit
//
//  Created by Jack Anderson on 12/22/23.
//

import Foundation
import FirebaseAuth

enum Sport: String, CaseIterable {
    case football = "Football"
    case basketball = "Basketball"
    case soccer = "Soccer"
    case baseball = "Baseball"
    case hockey = "Hockey"
    case mma = "MMA"
    
    var leagues: [String] {
        switch self {
        case .football:
            return ["americanfootball_nfl", "americanfootball_ncaaf"]
        case .basketball:
            return ["basketball_nba", "basketball_ncaab"]
        case .soccer:
            return ["soccer_uefa_europa_league", "soccer_spain_la_liga", "soccer_epl", "soccer_france_ligue_one", "soccer_italy_serie_a", "soccer_germany_bundesliga", "soccer_uefa_champs_league"]
        case .baseball:
            return ["baseball_mlb", "baseball_ncaa"]
        case .hockey:
            return ["icehockey_nhl"]
        case .mma:
            return ["mma_mixed_martial_arts"]
        }
    }
}

@MainActor
final class GamesViewModel: ObservableObject {
    
    @Published var games: [Game]? = []
    @Published var gameAverages: [String: (Double?, Double?, Double?)]? = [:]
    @Published var selectedSport: Sport = .football
    
    var gamesManager: GamesManager
    
    let key = "e37ef2b2520c5f2a152db29a1e2267c3"
    
    var url: URL {
        return URL(string: "https://api.the-odds-api.com/v4/sports/americanfootball_nfl/odds?markets=h2h,spreads,totals&regions=us&bookmakers=betmgm,draftkings,fanduel,pointsbetus&apiKey=\(key)")!
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
            try await gamesManager.fetchGamesFromURL(url: self.url, token: token)
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
    
}
