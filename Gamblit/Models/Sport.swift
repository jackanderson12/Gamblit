//
//  League.swift
//  Gamblit
//
//  Created by Jack Anderson on 1/4/24.
//

import Foundation

struct League: Hashable {
    let displayName: String
    let apiIdentifier: String
}

enum apiFilter: String {
    case sports = "sports"
    case event = "event"
    case historical = "historical"
}

enum Sport: String, CaseIterable, Hashable {
    case football = "Football"
    case basketball = "Basketball"
    case soccer = "Soccer"
    case baseball = "Baseball"
    case hockey = "Hockey"
    case mma = "MMA"
    
    var leagues: [League] {
        switch self {
        case .football:
            return [
                League(displayName: "NFL", apiIdentifier: "americanfootball_nfl"),
                League(displayName: "NCAA Football", apiIdentifier: "americanfootball_ncaaf")
            ]
        case .basketball:
            return [
                League(displayName: "NBA", apiIdentifier: "basketball_nba"),
                League(displayName: "NCAA Basketball", apiIdentifier: "basketball_ncaab")
            ]
        case .soccer:
            return [
                League(displayName: "UEFA Europa", apiIdentifier: "soccer_uefa_europa_league"),
                League(displayName: "UEFA - Champions League", apiIdentifier: "soccer_uefa_champs_league"),
                League(displayName: "England - Premier League", apiIdentifier: "soccer_epl"),
                League(displayName: "Spain - La Liga", apiIdentifier: "soccer_spain_la_liga"),
                League(displayName: "France - Ligue One", apiIdentifier: "soccer_france_ligue_one"),
                League(displayName: "Italy - Serie A", apiIdentifier: "soccer_italy_serie_a"),
                League(displayName: "Germany - Bundesliga", apiIdentifier: "soccer_germany_bundesliga"),
            ]
        case .baseball:
            return [
                League(displayName: "MLB", apiIdentifier: "baseball_mlb"),
                League(displayName: "NCAA", apiIdentifier: "baseball_ncaa")
            ]
        case .hockey:
            return [
                League(displayName: "NHL", apiIdentifier: "icehockey_nhl")
            ]
        case .mma:
            return [
                League(displayName: "MMA", apiIdentifier: "mma_mixed_martial_arts")
                ]
        }
    }
}
