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
            try await fetchGambles()
        }
    }
    
    func fetchGambles() async throws {
        self.gambles = try await GambleManagerRemodel.fetchGambles()
        try await fetchUserDataForGambles()
    }
    
    private func fetchUserDataForGambles() async throws {
        for i in 0..<gambles.count {
            let gamble = gambles[i]
            let userId = gamble.userId
            let gambleUser = try await UserManager.shared.getUser(userId: userId)
            
            gambles[i].user = gambleUser
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
