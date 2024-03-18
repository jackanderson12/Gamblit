//
//  GambleManager.swift
//  Gamblit
//
//  Created by Jack Anderson on 12/15/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

final class GambleManager {
    
    static let shared = GambleManager()
    private init() {}
    
    //MARK: Gamble Section
    
    private let gambleCollection = Firestore.firestore().collection("gambles")
    
    private var gambleListener: ListenerRegistration? = nil
    
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
    
    func addListenerForGambleFeed() -> AnyPublisher<[Gamble], Error> {
        let (publisher, listener) = gambleCollection.addSnapshotListener(as: Gamble.self)
        
        self.gambleListener = listener
        return publisher
    }
    
    //MARK: TableTalk Section
    
    private let tableTalkCollection = Firestore.firestore().collection("tableTalks")
    
    private var tableTalkListener: ListenerRegistration? = nil
    
    private func tableTalkDocument(tableTalkId: String) -> DocumentReference {
        tableTalkCollection.document(tableTalkId)
    }
    
    func uploadTableTalk(tableTalk: TableTalk) async throws {
        try tableTalkDocument(tableTalkId: tableTalk.id).setData(from: tableTalk, merge: false)
    }
    
    func getTableTalkForGamble(gambleId: String, count: Int, lastTableTalk: DocumentSnapshot?) async throws -> (tableTalks: [TableTalk], lastDocument: DocumentSnapshot?) {
        let gambleRef = gambleDocument(gambleId: gambleId)
        
        if let lastTableTalk {
            return try await tableTalkCollection
                .limit(to: count).whereField("gamble_reference", isEqualTo: gambleRef)
                .start(afterDocument: lastTableTalk)
                .getTableTalkDocumentsWithSnapshot(as: TableTalk.self)
        } else {
            return try await tableTalkCollection
                .limit(to: count)
                .whereField("gamble_reference", isEqualTo: gambleRef)
                .getTableTalkDocumentsWithSnapshot(as: TableTalk.self)
        }
    }
    
    func addListenerForAllTableTalksOnGamble() -> AnyPublisher<[TableTalk], Error> {
        let (publisher, listener) = tableTalkCollection.addSnapshotListener(as: TableTalk.self)
        
        self.tableTalkListener = listener
        return publisher
    }
    
}
