//
//  GambleDetailView.swift
//  Gamblit
//
//  Created by Jack Anderson on 3/7/24.
//

import SwiftUI

struct GambleDetailView: View {
    
    @StateObject private var viewModel = GambleDetailViewModel()
    @StateObject var profileViewModel: ProfileViewModel
    
    @Binding var gamble: Gamble
    @State private var tableTalks: [TableTalk] = []
    
    @State private var newTableTalk: Bool = false
    @State private var tableTalkContent: String = ""
    
    var body: some View {
        VStack {
            GambleCardView(Gamble: $gamble)
            
            Button {
                newTableTalk.toggle()
            } label: {
                Image(systemName: "plus")
            }
            
            ForEach($tableTalks, id:\.id) { tableTalk in
                TableTalkCellView(tableTalk: tableTalk)
            }
        }
        .task {
            try? await viewModel.getTableTalkForGamble(gambleId: gamble.id)
        }
        .sheet(isPresented: $newTableTalk) {
            VStack {
                TextField("Reply", text: $tableTalkContent)
                Button("Submit") {
                    Task {
                        try? await GambleManager.shared.uploadTableTalk(tableTalk: TableTalk(id: String("\(UUID())"), userId: profileViewModel.user!.userId, content: tableTalkContent, replies: []))
                    }
                }
            }
        }
    }
}
