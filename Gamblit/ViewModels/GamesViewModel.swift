//
//  GamesViewModel.swift
//  Gamblit
//
//  Created by Jack Anderson on 12/22/23.
//

import Foundation
import FirebaseAuth

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
    
    var gamesManager: GamesManager
    
    let key = "e37ef2b2520c5f2a152db29a1e2267c3"
    
    var url: URL {
        return URL(string: "https://api.the-odds-api.com/v4/sports/\(selectedLeague ?? "americanfootball_nfl" )/odds?markets=h2h,spreads,totals&regions=us&bookmakers=betmgm,draftkings,fanduel,pointsbetus&apiKey=\(key)")!
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
