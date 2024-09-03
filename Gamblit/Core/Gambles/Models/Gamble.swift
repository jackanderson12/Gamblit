//
//  Gamble.swift
//  Gamblit
//
//  Created by Jack Anderson on 12/11/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Gamble: Identifiable, Codable, Hashable {
    @DocumentID var gambleId: String?
    
    let userId: String
    let game: Game
    let bookmakers: [Bookmakers]
    
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
