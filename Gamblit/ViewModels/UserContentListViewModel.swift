//
//  UserContentListViewModel.swift
//  Gamblit
//
//  Created by Jack Anderson on 4/29/24.
//

import Foundation

@MainActor
class UserContentListViewModel: ObservableObject {
    
    @Published var gambles: [Gamble] = []
    
    let user: DBUser
    
    init(user: DBUser) {
        self.user = user
        Task {
            try await fetchGambles()
        }
    }
    
    func fetchGambles() async throws {
        var gambles = try await GambleManagerRemodel.fetchUserGambles(uid: user.userId ?? "No user id found")
        
        for i in 0 ..< gambles.count {
            gambles[i].user = self.user
        }
        
        self.gambles = gambles
    }
}
