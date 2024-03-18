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
    @State private var tableTalks: [TableTalk] = []
    
    var body: some View {
        VStack(alignment: .center) {
            GambleCardView(viewModel: viewModel, profileViewModel: profileViewModel, gamble: $gamble)
            List {
                ForEach($tableTalks, id: \.id) { tableTalk in
                    if tableTalk.gambleReference.wrappedValue == GambleManager.shared.gambleDocument(gambleId: gamble.id) {
                        TableTalkCellView(tableTalk: tableTalk)
                    }
                }
            }
        }
        .padding(.all)
        .task {
            tableTalks = []
            try? await viewModel.getTableTalkForGamble(gambleId: gamble.id)
            tableTalks = viewModel.tableTalks
        }
        .onFirstAppear {
            viewModel.addListenerForTableTalksOnGamble()
        }
    }
}
