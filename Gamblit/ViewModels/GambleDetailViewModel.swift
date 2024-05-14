//
//  GambleDetailViewModel.swift
//  Gamblit
//
//  Created by Jack Anderson on 3/7/24.
//

import Foundation
import FirebaseFirestore
import Combine

@MainActor
class GambleDetailViewModel: ObservableObject {
    
    @Published var tableTalks: [TableTalk] = []
    
    private let gamble: Gamble
    
    init(gamble: Gamble) {
        self.gamble = gamble
    }
    
    private func fetchTableTalks() async throws{
        self.tableTalks = try await TableTalkManager.fetchGambleTableTalks(forGambles: gamble)
    }
}
