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
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case userId = "user_id"
        case sportsBooks = "sports_books"
        case title = "title"
        case description = "description"
        case likes = "likes"
        case tableTalk = "table_talk"
    }
}

struct TableTalk: Identifiable, Codable {
    var id: String
    var userId: String
    var content: String
    var replies: [TableTalk]
}
