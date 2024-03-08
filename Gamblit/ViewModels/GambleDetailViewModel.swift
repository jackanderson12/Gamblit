//
//  GambleDetailViewModel.swift
//  Gamblit
//
//  Created by Jack Anderson on 3/7/24.
//

import Foundation
import FirebaseFirestore

@MainActor
final class GambleDetailViewModel: ObservableObject {
    
    @Published private(set) var tableTalks: [TableTalk] = []
    private var lastDocument: DocumentSnapshot? = nil
    
    func getTableTalkForGamble(gambleId: String) async throws {
        Task {
            let (tableTalksToShow, lastDocument) = try await GambleManager.shared.getTableTalkForGamble(gambleId: gambleId, count: 20, lastTableTalk: lastDocument)
            self.tableTalks.append(contentsOf: tableTalksToShow)
            self.lastDocument = lastDocument
        }
    }
    
    func updateGambleLikeCount(gambleId: String, likes: Int) async throws {
        try await GambleManager.shared.updateGambleLikeCount(gambleId: gambleId, likes: likes)
    }
    
    func uploadTableTalk(gambleId: String, userId: String, content: String) async throws {
        try await GambleManager.shared.uploadTableTalk(tableTalk: TableTalk(id: String("\(UUID())"), gambleReference: GambleManager.shared.gambleDocument(gambleId: gambleId), userId: userId, content: content, replies: []))
    }
}
