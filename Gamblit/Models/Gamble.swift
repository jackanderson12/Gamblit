//
//  Gamble.swift
//  Gamblit
//
//  Created by Jack Anderson on 12/11/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Gamble: Identifiable, Codable {
    @DocumentID var gambleId: String?
    
    let userId: String
    let game: Game
    //var sportsBooks: String
    let title: String
    let description: String
    let timestamp: Timestamp
    
    var tableTalkCount: Int
    var likes: Int
    var didLike: Bool? = false
    
    var id: String {
        return gambleId ?? UUID().uuidString
    }
    
    var user: DBUser?
}

struct TableTalk: Identifiable, Codable {
    @DocumentID var tableTalkId: String?
    
    let gambleId: String
    let gambleOwnerUserId: String
    let userId: String
    let content: String
    let timestamp: Timestamp
    
    var gamble: Gamble?
    var user: DBUser?
    
    var id: String {
        return tableTalkId ?? UUID().uuidString
    }
}
