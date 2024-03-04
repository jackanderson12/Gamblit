//
//  GambleFeedViewModel.swift
//  Gamblit
//
//  Created by Jack Anderson on 2/25/24.
//

import Foundation

@MainActor
final class GambleFeedViewModel: ObservableObject {
    
    @Published private(set) var gambles: [Gamble] = []
    
    func getAllGambles() async throws {
        Task {
            self.gambles = try await GambleManager.shared.getAllGambles()
        }
    }
    
    func getGamblesByLikes() {
        Task {
            let gamblesToAdd = try await GambleManager.shared.getGambleByLikes(count: 5, lastGamble: self.gambles.last)
            self.gambles.append(contentsOf: gamblesToAdd)
        }
    }
}
