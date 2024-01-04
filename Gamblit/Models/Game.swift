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
        case sportTitle = "sport_Title"
        case bookmakers
    }
    
    static func == (lhs: Game, rhs: Game) -> Bool {
        lhs.commenceTime == rhs.commenceTime
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(commenceTime)
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
    let outcome: [Outcome]?
}

struct Outcome: Codable {
    let name: String?
    let price: Double?
    let point: Double?
}
