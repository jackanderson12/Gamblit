//
//  Gamble.swift
//  Gamblit
//
//  Created by Jack Anderson on 12/11/23.
//

import Foundation

struct Gamble: Identifiable, Codable {
    var id: String
    var userId: String
//    var game: Game
    var sportsBooks: [String]
    var title: String
    var description: String
    var likes: Int
    var tableTalk: [TableTalk]
}

struct TableTalk: Identifiable, Codable {
    var id: String
    var userId: String
    var content: String
    var replies: [TableTalk]
}
