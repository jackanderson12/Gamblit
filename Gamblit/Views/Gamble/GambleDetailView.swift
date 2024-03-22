//
//  GambleDetailView.swift
//  Gamblit
//
//  Created by Jack Anderson on 3/7/24.
//

import SwiftUI

struct GambleDetailView: View {
    @StateObject var viewModel: GambleDetailViewModel
    @StateObject var profileViewModel: ProfileViewModel
    @Binding var gamble: Gamble
    
    var body: some View {
        LazyVStack(alignment: .center) {
            GambleCardView(viewModel: viewModel, profileViewModel: profileViewModel, gamble: $gamble)
            
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 16) {
                    ForEach(viewModel.filteredTableTalks(for: gamble.id), id: \.id) { tableTalk in
                        TableTalkView(tableTalk: tableTalk)
                            .padding(.horizontal)
                    }
                }
            }
        }
        .task {
            try? await viewModel.getTableTalkForGamble(gambleId: gamble.id)
        }
        .onFirstAppear {
            viewModel.addListenerForTableTalksOnGamble()
        }
    }
}

struct TableTalkView: View {
    let tableTalk: TableTalk
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(tableTalk.userId)
                    .font(.subheadline)
                    .fontWeight(.bold)
            }
            
            Text(tableTalk.content)
                .font(.body)
            
            if !tableTalk.replies.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(tableTalk.replies, id: \.id) { reply in
                        TableTalkView(tableTalk: reply)
                            .padding(.leading)
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .shadow(radius: 2)
    }
}
