//
//  Game.swift
//  Gamblit
//
//  Created by Jack Anderson on 12/22/23.
//

import Foundation

// MARK: - Game Model
struct Game: Identifiable, Codable, Hashable {
    let id: String?
    let commenceTime: String?
    let homeTeam: String?
    let awayTeam: String?
    let sportKey: String?
    let sportTitle: String?
    let bookmakers: [Bookmakers]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case commenceTime = "commence_time"
        case homeTeam = "home_team"
        case awayTeam = "away_team"
        case sportKey = "sport_key"
        case sportTitle = "sport_title"
        case bookmakers
    }
    
    static func == (lhs: Game, rhs: Game) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct Bookmakers: Codable {
    let key: String?
    let title: String?
    let lastUpdate: String?
    let markets: [Markets]?
    
    enum CodingKeys: String, CodingKey {
        case key
        case title
        case lastUpdate = "last_update"
        case markets
    }
}

struct Markets: Codable {
    let key: String?
    let lastUpdate: String?
    let outcomes: [Outcome]?
    
    enum CodingKeys: String, CodingKey {
        case key
        case lastUpdate = "last_update"
        case outcomes
    }
}

struct Outcome: Codable {
    let name: String?
    let price: Double?
    let point: Double?
}

struct Historical: Codable {
    let timestamp: String?
    let previousTimestamp: String?
    let nextTimestamp: String?
    let data: [Game]
    
    enum CodingKeys: String, CodingKey {
        case timestamp
        case previousTimestamp = "previous_timestamp"
        case nextTimestamp = "next_timestamp"
        case data
    }
}
