//
//  GambleManagerRemodel.swift
//  Gamblit
//
//  Created by Jack Anderson on 4/29/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct GambleManagerRemodel {
    
    static func uploadGamble(_ gamble: Gamble) async throws {
        guard let gambleData = try? Firestore.Encoder().encode(gamble) else { return }
        try await Firestore.firestore().collection("gambles").addDocument(data: gambleData)
    }
    
    static func fetchGambles() async throws -> [Gamble] {
        let snapshot = try await Firestore
            .firestore()
            .collection("gambles")
            .order(by: "timestamp", descending: true)
            .getDocuments()
        
        return snapshot.documents.compactMap({ try? $0.data(as: Gamble.self)})
    }
    
    static func fetchUserGambles(uid: String) async throws -> [Gamble] {
        let snapshot = try await Firestore
            .firestore()
            .collection("gambles")
            .whereField("userId", isEqualTo: uid)
            .getDocuments()
        
        let gambles = snapshot.documents.compactMap({ try? $0.data(as: Gamble.self) })
        return gambles.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() })
    }
    
}
