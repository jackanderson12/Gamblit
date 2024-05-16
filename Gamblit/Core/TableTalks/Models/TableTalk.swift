//
//  TableTalk.swift
//  Gamblit
//
//  Created by Jack Anderson on 5/15/24.
//

import Foundation
import Firebase
import FirebaseFirestore

struct TableTalk: Identifiable, Codable, Hashable {
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
