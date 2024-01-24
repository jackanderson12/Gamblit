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
    @Published var selectedBooks: [String]?
    @Published var selectedDate: String?
    @Published var selectedFilter: apiFilter? = .sports
    @Published var eventId: String?
    
    var gamesManager: GamesManager
    
    var url: URL {
        let baseURL = "https://us-central1-gamblit-47419.cloudfunctions.net/main"
        
        switch selectedFilter {
            
        case .sports:
            return URL(string: "\(baseURL)/sports?league=\(selectedLeague ?? "americanfootball_nfl")&markets=\(selectedMarkets?.compactMap { $0.key }.joined(separator: ",") ?? "h2h,totals,spreads")&bookmakers=\(selectedBooks?.compactMap { $0 }.joined(separator: ",") ?? "draftkings")")!
        case .event:
            return  URL(string: "\(baseURL)/event?league=\(selectedLeague ?? "americanfootball_nfl")&event_id=\(eventId ?? "")&markets=\(selectedMarkets?.compactMap { $0.key }.joined(separator: ",") ?? "h2h,totals,spreads")&bookmakers=\(selectedBooks?.compactMap { $0 }.joined(separator: ",") ?? "draftkings")")!
        case .historical:
            return URL(string: "\(baseURL)/historical?league=\(selectedLeague ?? "americanfootball_nfl")&markets=\(selectedMarkets?.compactMap { $0.key }.joined(separator: ",") ?? "h2h,totals,spreads")&bookmakers=\(selectedBooks?.compactMap { $0 }.joined(separator: ",") ?? "draftkings")&date=\(selectedDate ?? ISO8601DateFormatter().string(from: Date()))")!
        default:
            return URL(string: "\(baseURL)/sports?league=\(selectedLeague ?? "americanfootball_nfl")&markets=\(selectedMarkets?.compactMap { $0.key }.joined(separator: ",") ?? "h2h,totals,spreads")&bookmakers=\(selectedBooks?.compactMap { $0 }.joined(separator: ",") ?? "draftkings")")!
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
