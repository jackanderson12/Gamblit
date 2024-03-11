//
//  GambleManager.swift
//  Gamblit
//
//  Created by Jack Anderson on 12/15/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class GambleManager {
    
    static let shared = GambleManager()
    private init() {}
    
    private let gambleCollection = Firestore.firestore().collection("gambles")
    private let tableTalkCollection = Firestore.firestore().collection("tableTalks")
    
    //MARK: Gamble Section
    func gambleDocument(gambleId: String) -> DocumentReference {
        gambleCollection.document(gambleId)
    }
    
    func uploadGamble(gamble: Gamble) async throws {
        try gambleDocument(gambleId: gamble.id).setData(from: gamble, merge: false)
    }
    
    func getGamble(gambleId: String) async throws -> Gamble {
        try await gambleDocument(gambleId: gambleId).getDocument(as: Gamble.self)
    }
    
    func getAllGambles() async throws -> [Gamble] {
        try await gambleCollection.getDocuments(as: Gamble.self)
    }
    
    func getGambleByLikes(count: Int, lastGamble: DocumentSnapshot?) async throws -> (gambles: [Gamble], lastDocument: DocumentSnapshot?) {
        if let lastGamble {
            return try await gambleCollection
                .order(by: Gamble.CodingKeys.likes.rawValue, descending: true)
                .limit(to: count)
                .start(afterDocument: lastGamble)
                .getDocumentsWithSnapshot(as: Gamble.self)
        } else {
            return try await gambleCollection
                .order(by: Gamble.CodingKeys.likes.rawValue, descending: true)
                .limit(to: count)
                .getDocumentsWithSnapshot(as: Gamble.self)
        }
    }
    
    func updateGambleLikeCount(gambleId: String, likes: Int) async throws {
        try await gambleDocument(gambleId: gambleId).updateData(["likes": likes])
    }
    
    //MARK: TableTalk Section
    private func tableTalkDocument(tableTalkId: String) -> DocumentReference {
        tableTalkCollection.document(tableTalkId)
    }
    
    func uploadTableTalk(tableTalk: TableTalk) async throws {
        try tableTalkDocument(tableTalkId: tableTalk.id).setData(from: tableTalk, merge: false)
    }
    
    func getTableTalkForGamble(gambleId: String, count: Int, lastTableTalk: DocumentSnapshot?) async throws -> (tableTalks: [TableTalk], lastDocument: DocumentSnapshot?) {
        let gambleRef = gambleDocument(gambleId: gambleId)
        
        if let lastTableTalk {
            return try await tableTalkCollection.limit(to: count).whereField("gamble_reference", isEqualTo: gambleRef).start(afterDocument: lastTableTalk).getTableTalkDocumentsWithSnapshot(as: TableTalk.self)
        } else {
            return try await tableTalkCollection.limit(to: count).whereField("gamble_reference", isEqualTo: gambleRef).getTableTalkDocumentsWithSnapshot(as: TableTalk.self)
        }
    }
    
}

extension Query {
    
    func getDocuments<T>(as type: T.Type) async throws -> [T] where T: Decodable {
        let snapshot = try await self.getDocuments()
        
        return try snapshot.documents.map({ document in
            try document.data(as: T.self)
        })
    }
    
    func getDocumentsWithSnapshot<T>(as type: T.Type) async throws -> (gambles: [T], lastDocument: DocumentSnapshot?) where T: Decodable {
        let snapshot = try await self.getDocuments()
        
        let gambles = try snapshot.documents.map({ document in
            try document.data(as: T.self)
        })
        
        return (gambles, snapshot.documents.last)
    }
    
    
    func getTableTalkDocumentsWithSnapshot<T>(as type: T.Type) async throws -> (tableTalks: [T], lastDocument: DocumentSnapshot?) where T: Decodable {
        let snapshot = try await self.getDocuments()
        
        let tableTalks = try snapshot.documents.map({ document in
            try document.data(as: T.self)
        })
        
        return (tableTalks, snapshot.documents.last)
    }
    
}
