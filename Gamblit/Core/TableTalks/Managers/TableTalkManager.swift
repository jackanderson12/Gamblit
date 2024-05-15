//
//  TableTalkManager.swift
//  Gamblit
//
//  Created by Jack Anderson on 5/10/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct TableTalkManager {
    
    static func uploadTableTalk(_ tableTalk: TableTalk, toGamble gamble: Gamble) async throws {
        guard let tableTalkData = try? Firestore.Encoder().encode(tableTalk) else { return }
        async let _ = try await FirestoreConstants.tableTalkCollection.document().setData(tableTalkData)
        async let _ = try await FirestoreConstants.gambleCollection.document(gamble.id).updateData([
            "tableTalkCount" : gamble.tableTalkCount + 1
        ])
    }
    
    static func fetchGambleTableTalks(forGambles gamble: Gamble) async throws -> [TableTalk] {
        let snapshot = try await FirestoreConstants.tableTalkCollection
            .whereField("gambleId", isEqualTo: gamble.id)
            .getDocuments()
        
        return snapshot.documents.compactMap({ try? $0.data(as: TableTalk.self) })
    }
    
    static func fetchGambleTableTalks(forUser user: DBUser) async throws -> [TableTalk] {
        let snapshot = try await FirestoreConstants.tableTalkCollection
            .whereField("gambleOwnerUserId", isEqualTo: user.id)
            .getDocuments()
        
        return snapshot.documents.compactMap({ try? $0.data(as: TableTalk.self) })
    }
}
