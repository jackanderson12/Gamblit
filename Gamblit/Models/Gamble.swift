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
    var likes: Int
    let timestamp: Timestamp
    
    var id: String {
        return gambleId ?? UUID().uuidString
    }
    
    var user: DBUser?
}

struct TableTalk: Identifiable, Codable {
    let id: String
    let gambleReference: DocumentReference
    let userId: String
    let content: String
    var replies: [TableTalk]
    let timestamp: Timestamp
}
