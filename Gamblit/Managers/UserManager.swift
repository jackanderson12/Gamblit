//
//  UserManager.swift
//  Gamblit
//
//  Created by Jack Anderson on 12/14/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

final class UserManager {
    
    @Published var currentUser: DBUser?
    
    static let shared = UserManager()
    init() {
        Task {
            try await fetchCurrentUser()
        }
    }
    
    private let userCollection = Firestore.firestore().collection("users")
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    @MainActor 
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await userCollection.document(uid).getDocument()
        let user = try snapshot.data(as: DBUser.self)
        self.currentUser = user
    }
    
    func createNewUser(user: DBUser) async throws {
        try userDocument(userId: user.userId!).setData(from: user, merge: false)
    }
    
    func createNewUser(auth: AuthDataResultModel) async throws {
        var userData: [String:Any] = [
            "user_id" : auth.uid,
            "is_anonymous" : auth.isAnonymous,
            "date_created" : Timestamp(),
        ]
        if let profileImageUrl = auth.profileImageUrl {
            userData["profileImageUrl"] = profileImageUrl
        }
        
        try await userDocument(userId: auth.uid).setData(userData, merge: false)
    }
    
    func getUser(userId: String) async throws -> DBUser {
        try await userDocument(userId: userId).getDocument(as: DBUser.self)
    }
    
    func getAllUsers() async throws -> [DBUser] {
        try await userCollection.getDocuments(as: DBUser.self)
    }
    
    //MARK: Photo Functionality
    @MainActor
    func updateUserProfileImage(userId: String, withImageUrl imageUrl: String) async throws {
        let data: [String:Any] = ["profileImageUrl": imageUrl]
        try await userDocument(userId: userId).updateData(data)
    }
    
    //MARK: Premium Functionality
    func updateUserPremiumStatus(userId: String, isPremium: Bool) async throws {
        let data: [String:Any] = [
            DBUser.CodingKeys.isPremium.rawValue : isPremium
        ]
        try await userDocument(userId: userId).updateData(data)
    }
    
    //MARK: Sportsbooks Functionality
    
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
