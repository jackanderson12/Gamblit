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
        try await gambleDocument(gambleId: gambleId).getDocument(as: Gamble.self)
    }
    
    func getAllGambles() async throws -> [Gamble] {
        try await gambleCollection.getDocuments(as: Gamble.self)
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
