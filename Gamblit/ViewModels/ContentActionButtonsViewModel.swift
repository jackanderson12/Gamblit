//
//  ContentActionButtonsViewModel.swift
//  Gamblit
//
//  Created by Jack Anderson on 5/7/24.
//

import Foundation

@MainActor
class ContentActionButtonsViewModel: ObservableObject {
    @Published var gamble: Gamble
    
    init(gamble: Gamble) {
        self.gamble = gamble
        Task {
            try await checkIfUserLikedGamble()
        }
    }
    
    func likeGamble() async throws {
        try await GambleManagerRemodel.likeGamble(gamble)
        self.gamble.didLike = true
        self.gamble.likes += 1
    }
    
    func unlikeGamble() async throws {
        try await GambleManagerRemodel.unlikeGamble(gamble)
        self.gamble.didLike = false
        self.gamble.likes -= 1
    }
    
    func checkIfUserLikedGamble() async throws {
        let didlike = try await GambleManagerRemodel.checkIfUserLikedGamble(gamble)
        
        if didlike {
            self.gamble.didLike = true
        }
    }
}
