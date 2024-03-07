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
//        case game = "game"
        case sportsBooks = "sports_books"
        case title = "title"
        case description = "description"
        case likes = "likes"
        case tableTalk = "table_talk"
    }
    
//    init(id: String, userId: String, sportsBooks: [String], title: String, description: String, likes: Int, tableTalk: [TableTalk]) {
//        self.id = id
//        self.userId = userId
//        self.sportsBooks = sportsBooks
//        self.title = title
//        self.description = description
//        self.likes = likes
//        self.tableTalk = tableTalk
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(String.self, forKey: .id)
//        self.userId = try container.decode(String.self, forKey: .userId)
//        self.sportsBooks = try container.decode([String].self, forKey: .sportsBooks)
//        self.title = try container.decode(String.self, forKey: .title)
//        self.description = try container.decode(String.self, forKey: .description)
//        self.likes = try container.decode(Int.self, forKey: .likes)
//        self.tableTalk = try container.decode([TableTalk].self, forKey: .tableTalk)
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(self.id, forKey: .id)
//        try container.encode(self.userId, forKey: .userId)
//        try container.encode(self.sportsBooks, forKey: .sportsBooks)
//        try container.encode(self.title, forKey: .title)
//        try container.encode(self.id, forKey: .description)
//        try container.encode(self.id, forKey: .likes)
//        try container.encodeIfPresent(self.id, forKey: .tableTalk)
//        
//    }
}

struct TableTalk: Identifiable, Codable {
    var id: String
    var userId: String
    var content: String
    var replies: [TableTalk]
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case content
        case replies
    }
    
//    init(id: String, userId: String, content: String, replies: [TableTalk]) {
//        self.id = id
//        self.userId = userId
//        self.content = content
//        self.replies = replies
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(String.self, forKey: .id)
//        self.userId = try container.decode(String.self, forKey: .userId)
//        self.content = try container.decode(String.self, forKey: .content)
//        self.replies = try container.decode([TableTalk].self, forKey: .replies)
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(self.id, forKey: .id)
//        try container.encode(self.userId, forKey: .userId)
//        try container.encode(self.content, forKey: .content)
//        try container.encode(self.replies, forKey: .replies)
//    }
}
