//
//  TableTalkViewModel.swift
//  Gamblit
//
//  Created by Jack Anderson on 5/10/24.
//

import Foundation
import Firebase

class TableTalkViewModel: ObservableObject {
    
    func uploadTableTalk(tableTalkText: String, gamble: Gamble) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let tableTalk = TableTalk(gambleId: gamble.id, 
                                  gambleOwnerUserId: gamble.userId,
                                  userId: uid,
                                  content: tableTalkText,
                                  timestamp: Timestamp())
        try await TableTalkManager.uploadTableTalk(tableTalk, toGamble: gamble)
    }
}
