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
        self.gambles = try await GambleManager.shared.getAllGambles()
    }
}
