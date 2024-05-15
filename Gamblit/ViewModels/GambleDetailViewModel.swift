//
//  GambleDetailViewModel.swift
//  Gamblit
//
//  Created by Jack Anderson on 3/7/24.
//

import Foundation
import FirebaseFirestore

@MainActor
class GambleDetailViewModel: ObservableObject {
    
    @Published var tableTalks: [TableTalk] = []
    
    private let gamble: Gamble
    
    init(gamble: Gamble) {
        self.gamble = gamble
        Task {
            try await fetchTableTalks()
        }
    }
    
    private func fetchTableTalks() async throws{
        self.tableTalks = try await TableTalkManager.fetchGambleTableTalks(forGambles: gamble)
        try await fetchUserDataForTableTalks()
    }
    
    private func fetchUserDataForTableTalks() async throws {
        for i in 0 ..< tableTalks.count {
            let tabletalk = tableTalks[i]
            
            async let user = try await UserManager.shared.getUser(userId: tabletalk.userId)
            self.tableTalks[i].user = try await user
        }
    }
}
