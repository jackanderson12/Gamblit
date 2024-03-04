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
    
    private func gambleDocument(gambleId: String) -> DocumentReference {
        gambleCollection.document(gambleId)
    }
    
    func uploadGamble(gamble: Gamble) async throws {
        try gambleDocument(gambleId: gamble.id).setData(from: gamble, merge: false)
    }
    
    func getGamble(gambleId: String) async throws -> Gamble {
        try await gambleDocument(gambleId: gambleId)
            .getDocument(as: Gamble.self)
    }
    
    func getAllGambles() async throws -> [Gamble] {
        try await gambleCollection
            .getDocuments(as: Gamble.self)
    }
    
    func getGambleByLikes(count: Int, lastGamble: Gamble?) async throws -> [Gamble] {
        try await gambleCollection
            .order(by: Gamble.CodingKeys.likes.rawValue, descending: true)
            .limit(to: count)
            .start(afterDocument: lastGamble ?? Gamble(id: <#T##String#>, userId: <#T##String#>, sportsBooks: <#T##[String]#>, title: <#T##String#>, description: <#T##String#>, likes: <#T##Int#>, tableTalk: <#T##[TableTalk]#>))
            .getDocuments(as: Gamble.self)
    }
}

extension Query {
    
    func getDocuments<T>(as type: T.Type) async throws -> [T] where T: Decodable {
        let snapshot = try await self.getDocuments()
        
        return try snapshot.documents.map({ document in
            try document.data(as: T.self)
        })
    }
}
