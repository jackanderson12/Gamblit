//
//  GamesManager.swift
//  Gamblit
//
//  Created by Jack Anderson on 12/22/23.
//

import Foundation

@MainActor
final class GamesManager {
    
    @Published var games: [Game] = []
    @Published var gameAverages: [String: (Double?, Double?, Double?)] = [:]
    
    let key = "e37ef2b2520c5f2a152db29a1e2267c3"
    
    let exampleURL = URL(string: "")
    
    func fetchGamesFromURL(url: URL, token: String?) async throws {
        var request = URLRequest(url: url)
        //        if let token = token {
        //            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        //        }
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            print(response)
            try handleResponse(data: data, response: response)
        } catch {
            throw error
        }
    }
    
    func handleResponse(data: Data?, response: URLResponse?) throws {
        guard
            let data = data,
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            return
        }
        do {
            let decodeResults = try JSONDecoder().decode([Game].self, from: data)
            games = decodeResults
            calculateAverages()
        } catch {
            throw error
        }
    }
    
    func calculateAverages() {
        for game in games {
            if let gameId = game.id {
                gameAverages[gameId] = calculateGameAverages(game)
            }
        }
    }
    
    func calculateGameAverages(_ game: Game) -> (Double?, Double?, Double?) {
        var h2h: [Double] = []
        var total: [Double] = []
        var spreads: [Double] = []
        
        game.bookmakers?.forEach { bookmaker in
            bookmaker.markets?.forEach { market in
                switch market.key {
                case "h2h":
                    calculateGameH2HAverage(h2hs: &h2h, outcomes: market.outcome ?? [])
                case "totals":
                    calculateGameTotalAverage(totals: &total, outcomes: market.outcome ?? [])
                case "spreads":
                    calculateGameSpreadAverage(spreads: &spreads, outcomes: market.outcome ?? [])
                default:
                    break
                }
            }
        }
        
        let h2hAverage = h2h.isEmpty ? nil : h2h.reduce(0, +) / Double(h2h.count)
        let totalAverage = total.isEmpty ? nil : total.reduce(0, +) / Double(total.count)
        let spreadsAverage = spreads.isEmpty ? nil : spreads.reduce(0, +) / Double(spreads.count)
        
        return (h2hAverage, totalAverage, spreadsAverage)
    }
    
    func calculateGameSpreadAverage(spreads: inout [Double], outcomes: [Outcome]) {
        for outcome in outcomes {
            if let price = outcome.price {
                spreads.append(price)
            }
        }
    }
    
    func calculateGameTotalAverage(totals: inout [Double], outcomes: [Outcome]) {
        for outcome in outcomes {
            if let point = outcome.point {
                totals.append(point)
            }
        }
    }
    
    func calculateGameH2HAverage(h2hs: inout [Double], outcomes: [Outcome]) {
        for outcome in outcomes {
            if let price = outcome.price {
                h2hs.append(price)
            }
        }
    }
}
