//
//  GambleFeedViewModel.swift
//  Gamblit
//
//  Created by Jack Anderson on 2/25/24.
//

import Foundation
import FirebaseFirestore

@MainActor
final class GambleFeedViewModel: ObservableObject {
    
    @Published private(set) var gambles: [Gamble] = []
    private var lastDocument: DocumentSnapshot? = nil
    
    func getAllGambles() async throws {
        Task {
            self.gambles = try await GambleManager.shared.getAllGambles()
            print(gambles)
        }
    }
    
    func getGamblesByLikes() {
        Task {
            let (gamblesToShow, lastDocument) = try await GambleManager.shared.getGambleByLikes(count: 5, lastGamble: lastDocument)
            self.gambles.append(contentsOf: gamblesToShow)
            self.lastDocument = lastDocument
        }
    }
}
