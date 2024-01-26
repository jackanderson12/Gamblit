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
    @Published var gameAverages: [String: (Double?, Double?, Double?, Double?, Double?, Double?)] = [:]
    
    let key = "e37ef2b2520c5f2a152db29a1e2267c3"
    
    let exampleURL = URL(string: "")
    
    func fetchGamesFromURL(url: URL, token: String?, apiFilter: apiFilter) async throws {
        var request = URLRequest(url: url)
        if let token = token {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            switch apiFilter {
            case .sports:
                try handleSportsResponse(data: data, response: response)
            case .event:
                try handleEventResponse(data: data, response: response)
            case .historical:
                try handleHistoricalResponse(data: data, response: response)
            }
        } catch {
            throw error
        }
    }
    
    func handleSportsResponse(data: Data?, response: URLResponse?) throws {
        guard
            let data = data,
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            return
        }
        do {
            let decodeResults = try JSONDecoder().decode([Game].self, from: data)
            games = []
            games = decodeResults
        } catch {
            throw error
        }
    }
    
    func handleEventResponse(data: Data?, response: URLResponse?) throws {
        guard
            let data = data,
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            return
        }
        do {
            let decodeResults = try JSONDecoder().decode(Game.self, from: data)
            games = []
            games.append(decodeResults)
        } catch {
            throw error
        }
    }
    
    func handleHistoricalResponse(data: Data?, response: URLResponse?) throws {
        guard
            let data = data,
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            return
        }
        do {
            let decodeResults = try JSONDecoder().decode(Historical.self, from: data)
            games = decodeResults.data
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
    
    func calculateGameAverages(_ game
                               : Game) -> (Double?, Double?, Double?, Double?, Double?, Double?) {
        
        var h2hHomeTeam: [Double] = []
        var h2hAwayTeam: [Double] = []
        var totalOver: [Double] = []
        var totalUnder: [Double] = []
        var spreadHomeTeam: [Double] = []
        var spreadAwayTeam: [Double] = []
        
        game.bookmakers?.forEach { bookmaker in
            bookmaker.markets?.forEach { market in
                switch market.key {
                case "h2h":
                    calculateGameH2HAverage(game: game, h2hHomeTeam: &h2hHomeTeam, h2hAwayTeam: &h2hAwayTeam, outcomes: market.outcomes ?? [])
                case "totals":
                    calculateGameTotalAverage(game: game, totalOver: &totalOver, totalUnder: &totalUnder, outcomes: market.outcomes ?? [])
                case "spreads":
                    calculateGameSpreadAverage(game: game, spreadHomeTeam: &spreadHomeTeam, spreadAwayTeam: &spreadAwayTeam, outcomes: market.outcomes ?? [])
                default:
                    break
                }
            }
        }
        
        let h2hHomeTeamAverage = h2hHomeTeam.isEmpty ? nil : averageDecimalOddsToAmericanOdds(oddsArray: h2hHomeTeam)
        let h2hAwayTeamAverage = h2hAwayTeam.isEmpty ? nil : averageDecimalOddsToAmericanOdds(oddsArray: h2hAwayTeam)
        let totalOverAverage = totalOver.isEmpty ? nil : totalOver.reduce(0, +) / Double(totalOver.count)
        let totalUnderAverage = totalUnder.isEmpty ? nil : totalUnder.reduce(0, +) / Double(totalUnder.count)
        let spreadHomeTeamAverage = spreadHomeTeam.isEmpty ? nil : spreadHomeTeam.reduce(0, +) / Double(spreadHomeTeam.count)
        let spreadAwayTeamAverage = spreadAwayTeam.isEmpty ? nil : spreadAwayTeam.reduce(0, +) / Double(spreadAwayTeam.count)
        
        return (h2hHomeTeamAverage, h2hAwayTeamAverage, totalOverAverage, totalUnderAverage, spreadHomeTeamAverage, spreadAwayTeamAverage)
    }
    
    func calculateGameSpreadAverage(game: Game, spreadHomeTeam: inout [Double], spreadAwayTeam: inout [Double], outcomes: [Outcome]) {
        for outcome in outcomes {
            if let teamName = outcome.name {
                switch teamName {
                case game.homeTeam:
                    if let point = outcome.point {
                        spreadHomeTeam.append(point)
                    }
                case game.awayTeam:
                    if let point = outcome.point {
                        spreadAwayTeam.append(point)
                    }
                default:
                    break
                }
            }
        }
    }
    
    func calculateGameTotalAverage(game: Game, totalOver: inout [Double], totalUnder: inout [Double], outcomes: [Outcome]) {
        for outcome in outcomes {
            if let name = outcome.name {
                switch name {
                case "Over":
                    if let point = outcome.point {
                        totalOver.append(point)
                    }
                case "Under":
                    if let point = outcome.point {
                        totalUnder.append(point)
                    }
                default:
                    break
                }
            }
        }
    }
    
    func calculateGameH2HAverage(game: Game, h2hHomeTeam: inout [Double], h2hAwayTeam: inout [Double], outcomes: [Outcome]) {
        for outcome in outcomes {
            if let teamName = outcome.name {
                switch teamName {
                case game.homeTeam:
                    if let price = outcome.price {
                        h2hHomeTeam.append(price)
                    }
                case game.awayTeam:
                    if let price = outcome.price {
                        h2hAwayTeam.append(price)
                    }
                default:
                    break
                }
            }
        }
    }
    
    func averageDecimalOddsToAmericanOdds(oddsArray: [Double]) -> Double {
        var average = oddsArray.reduce(0, +) / Double(oddsArray.count)
        switch average {
        case 0..<2:
            average = 100 / (1 - average)
        case 2...:
            average = (average - 1) * 100
        default:
            break
        }
        return average
    }
}
