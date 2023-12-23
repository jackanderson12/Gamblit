//
//  Game.swift
//  Gamblit
//
//  Created by Jack Anderson on 12/22/23.
//

import Foundation

// MARK: - Game Model
struct Game: Identifiable, Codable, Hashable {
    let id: String
    let startDate: String
    let homeTeam: String
    let awayTeam: String
    let isLive: Bool
    let isPopular: Bool
    let tournament: String? // Assuming this could be null as seen in your JSON
    let status: String
    let sport: String
    let league: String

    enum CodingKeys: String, CodingKey {
        case id
        case startDate = "start_date"
        case homeTeam = "home_team"
        case awayTeam = "away_team"
        case isLive = "is_live"
        case isPopular = "is_popular"
        case tournament
        case status
        case sport
        case league
    }
}
