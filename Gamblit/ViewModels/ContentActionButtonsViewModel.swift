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
    
    func likeGamble() {
        self.gamble.didLike = true
    }
    
    func unlikeGamble() {
        self.gamble.didLike = false
    }
}
