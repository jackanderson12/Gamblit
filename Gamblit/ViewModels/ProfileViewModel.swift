//
//  ProfileViewModel.swift
//  Gamblit
//
//  Created by Jack Anderson on 12/14/23.
//

import Foundation

@MainActor
final class ProfileViewModel: ObservableObject {
    
    @Published private (set) var user: DBUser? = nil
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
    
    func togglePremiumStatus() {
        guard let user else { return }
        let currentValue = user.isPremium ?? false
        Task {
            try await UserManager.shared.updateUserPremiumStatus(userId: user.userId, isPremium: !currentValue)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    
    func addUserSportsBooks(sportsBooks: String) {
        guard let user else { return }
        
        Task {
            try await UserManager.shared.addUserSportsBooks(userId: user.userId, sportsBooks: sportsBooks)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    
    func removeUserSportsBooks(sportsBooks: String) {
        guard let user else { return }
        
        Task {
            try await UserManager.shared.removeUserSportsBooks(userId: user.userId, sportsBooks: sportsBooks)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
}
