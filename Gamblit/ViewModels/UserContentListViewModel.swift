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
    @Published var tableTalks: [TableTalk] = []
    
    let user: DBUser
    
    init(user: DBUser) {
        self.user = user
        Task {
            try await fetchGambles()
        }
        Task {
            try await fetchUserTableTalks()
        }
    }
    
    func fetchGambles() async throws {
        var gambles = try await GambleManagerRemodel.fetchUserGambles(uid: user.userId ?? "No user id found")
        
        for i in 0 ..< gambles.count {
            gambles[i].user = self.user
        }
        
        self.gambles = gambles
    }
    
    func fetchUserTableTalks() async throws {
        self.tableTalks = try await GambleManagerRemodel.fetchUserTableTalks(forUser: user)
        try await fetchTableTalkGambleData()
    }
    
    func fetchTableTalkGambleData() async throws {
        for i in 0 ..< tableTalks.count {
            let tableTalk = tableTalks[i]
            
            var gamble = try await GambleManagerRemodel.fetchGamble(gambleId: tableTalk.gambleId)
            gamble.user = try await UserManager.shared.getUser(userId: gamble.userId)
            
            tableTalks[i].gamble = gamble
        }
    }
}
