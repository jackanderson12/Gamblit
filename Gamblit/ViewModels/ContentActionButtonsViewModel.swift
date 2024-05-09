//
//  ContentActionButtonsViewModel.swift
//  Gamblit
//
//  Created by Jack Anderson on 5/7/24.
//

import Foundation

class ContentActionButtonsViewModel: ObservableObject {
    @Published var gamble: Gamble
    
    init(gamble: Gamble) {
        self.gamble = gamble
    }
    
    func likeGamble() async throws {
        try await GambleManagerRemodel.likeGamble(gamble)
        self.gamble.didLike = true
        self.gamble.likes += 1
    }
    
    func unlikeGamble() {
        self.gamble.didLike = false
    }
}
