//
//  Event.swift
//  Gamblit
//
//  Created by Jack Anderson on 12/12/23.
//

import Foundation

struct Event: Codable {
    var id: String
    var sportKey: String
    var sportTitle: String
    var commenceTime: String
    var homeTeam: String
    var awayTeam: String
    var bookmakers: [Bookmaker]
    
    enum CodingKeys: String, CodingKey {
        case id
        case sportKey = "sport_key"
        case sportTitle = "sport_title"
        case commenceTime = "commence_time"
        case homeTeam = "home_team"
        case awayTeam = "away_team"
        case bookmakers
    }
}

struct Bookmaker: Codable {
    var key: String
    var title: String
    var lastUpdate: String
    var markets: [Market]
    
    enum CodingKeys: String, CodingKey {
        case key
        case title
        case lastUpdate = "last_update"
        case markets
    }
}

struct Market: Codable {
    var key: String
    var lastUpdate: String
    var outcomes: [Outcome]
    
    enum CodingKeys: String, CodingKey {
        case key
        case lastUpdate = "last_update"
        case outcomes
    }
}

struct Outcome: Codable {
    var name: String
    var price: Double
    var point: Double?
}

