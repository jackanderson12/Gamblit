//
//  UserManager.swift
//  Gamblit
//
//  Created by Jack Anderson on 12/14/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class UserManager {
    static let shared = UserManager()
    private init() { }
    
    private let userCollection = Firestore.firestore().collection("users")
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    func createNewUser(user: DBUser) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: false)
    }
    
    func createNewUser(auth: AuthDataResultModel) async throws {
        var userData: [String:Any] = [
            "user_id" : auth.uid,
            "is_anonymous" : auth.isAnonymous,
            "date_created" : Timestamp(),
        ]
        if let photoUrl = auth.photoUrl {
            userData["photo_url"] = photoUrl
        }
        
        try await userDocument(userId: auth.uid).setData(userData, merge: false)
    }
    
    func getUser(userId: String) async throws -> DBUser {
        try await userDocument(userId: userId).getDocument(as: DBUser.self)
    }
    
    func getAllUsers() async throws -> [DBUser] {
        try await userCollection.getDocuments(as: DBUser.self)
    }
    
    func updateUserPremiumStatus(userId: String, isPremium: Bool) async throws {
        let data: [String:Any] = [
            DBUser.CodingKeys.isPremium.rawValue : isPremium
        ]
        try await userDocument(userId: userId).updateData(data)
    }
    
    func addUserSportsBooks(userId: String, sportsBooks: String) async throws {
        let data: [String:Any] = [
            DBUser.CodingKeys.sportsBooks.rawValue : FieldValue.arrayUnion([sportsBooks])
        ]
        try await userDocument(userId: userId).updateData(data)
    }
    
    func removeUserSportsBooks(userId: String, sportsBooks: String) async throws {
        let data: [String:Any] = [
            DBUser.CodingKeys.sportsBooks.rawValue : FieldValue.arrayRemove([sportsBooks])
        ]
        try await userDocument(userId: userId).updateData(data)
    }
        
}
