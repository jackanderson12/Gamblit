//
//  Gamble.swift
//  Gamblit
//
//  Created by Jack Anderson on 12/11/23.
//

import Foundation
import FirebaseFirestore

struct Gamble: Identifiable, Codable {
    var id: String
    var userId: String
//    var game: Game
    var sportsBooks: [String]
    var title: String
    var description: String
    var likes: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case userId = "user_id"
//        case game = "game"
        case sportsBooks = "sports_books"
        case title = "title"
        case description = "description"
        case likes = "likes"
    }
}

struct TableTalk: Identifiable, Codable {
    var id: String
    var gambleReference: DocumentReference
    var userId: String
    var content: String
    var replies: [TableTalk]
    
    enum CodingKeys: String, CodingKey {
        case id
        case gambleReference = "gamble_reference"
        case userId = "user_id"
        case content
        case replies
    }
}
