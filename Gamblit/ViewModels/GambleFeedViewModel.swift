//
//  GambleFeedViewModel.swift
//  Gamblit
//
//  Created by Jack Anderson on 2/25/24.
//

import Foundation
import FirebaseFirestore
import Combine

@MainActor
final class GambleFeedViewModel: ObservableObject {
    
    @Published var gambles: [Gamble] = []
    private var lastDocument: DocumentSnapshot? = nil
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        Task {
            try await getAllGambles()
        }
    }
    
    func getAllGambles() async throws {
        Task {
            self.gambles = try await GambleManager.shared.getAllGambles()
        }
    }
    
    func getGamblesByLikes() {
        Task {
            let (gamblesToShow, lastDocument) = try await GambleManager.shared.getGambleByLikes(count: 5, lastGamble: lastDocument)
            self.gambles.append(contentsOf: gamblesToShow)
            self.lastDocument = lastDocument
        }
    }
    
    func addListenerForTableTalksOnGamble() {
        GambleManager.shared.addListenerForGambleFeed()
            .sink { completion in
            
            } receiveValue: { [weak self] newGambles in
                self?.gambles = newGambles
            }
            .store(in: &cancellables)
    }
}
