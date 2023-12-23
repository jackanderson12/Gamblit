//
//  GamesViewModel.swift
//  Gamblit
//
//  Created by Jack Anderson on 12/22/23.
//

import Foundation

@MainActor
final class GamesViewModel: ObservableObject {
    @Published var games: [Game]? = []
    
    func getLeagues(sport: String) -> [String] {
        switch sport {
        case "Football":
            return ["NFL", "NCAA"]
        case "Basketball":
            return ["NBA", "NCAA"]
        case "Soccer":
            return ["UEFA - Europa League", "Spain - La Liga", "England - Premier League", "France - Ligue 1", "Italy - Serie A", "Germany - Bundesliga", "UEFA - Champions League"]
        case "Baseball":
            return ["MLB", "NCAA"]
        case "Hockey":
            return ["NHL"]
        case "MMA":
            return ["UFC"]
        default:
            return []
        }
    }
}
