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
    
    static func fetchGamble(gambleId: String) async throws -> Gamble {
        let snapshot = try await FirestoreConstants.gambleCollection
            .document(gambleId)
            .getDocument()
        
        return try snapshot.data(as: Gamble.self)
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
    
    static func fetchUserTableTalks(forUser user: DBUser) async throws -> [TableTalk] {
        let snapshot = try await FirestoreConstants.tableTalkCollection
            .whereField("userId", isEqualTo: user.id)
            .getDocuments()
        
        var tableTalks = snapshot.documents.compactMap({ try? $0.data(as: TableTalk.self) })
        
        for i in 0 ..< tableTalks.count {
            tableTalks[i].user = user
        }
        
        return tableTalks
    }
    
    //MARK: - Likes Functionality
    static func likeGamble(_ gamble: Gamble) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let gambleReference = FirestoreConstants.gambleCollection.document(gamble.id)
        
        async let _ = try await gambleReference.collection("gamble-likes").document(uid).setData([:])
        async let _ = try await gambleReference.updateData(["likes": gamble.likes + 1])
        async let _ = try await FirestoreConstants.userCollection.document(uid).collection("user-likes").document(gamble.id).setData([:])
    }
    static func unlikeGamble(_ gamble: Gamble) async throws {
        guard gamble.likes > 0 else { return }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let gambleReference = FirestoreConstants.gambleCollection.document(gamble.id)
        
        async let _ = gambleReference.collection("gamble-likes").document(uid).delete()
        async let _ = try await gambleReference.updateData(["likes": gamble.likes - 1])
        async let _ = try await FirestoreConstants.userCollection.document(uid).collection("user-likes").document(gamble.id).delete()
    }
    static func checkIfUserLikedGamble(_ gamble: Gamble) async throws -> Bool {
        guard let uid = Auth.auth().currentUser?.uid else { return false }
        
        let snapshot = try await FirestoreConstants.userCollection
            .document(uid)
            .collection("user-likes")
            .document(gamble.id)
            .getDocument()
        
        return snapshot.exists
    }
    
    
}
