//
//  ContentActionButtonsView.swift
//  Gamblit
//
//  Created by Jack Anderson on 5/7/24.
//

import SwiftUI

struct ContentActionButtonsView: View {
    @ObservedObject var viewModel: ContentActionButtonsViewModel
    
    @State private var showTableTalkSheet: Bool = false
    
    init(gamble: Gamble) {
        self.viewModel = ContentActionButtonsViewModel(gamble: gamble)
    }
    
    private var didLike: Bool {
        return viewModel.gamble.didLike ?? false
    }
    
    private var gamble: Gamble {
        return viewModel.gamble
    }
    
    func handleLikeTapped() {
        Task {
            if didLike {
                try await viewModel.unlikeGamble()
            } else {
                try await viewModel.likeGamble()
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 16) {
                Button {
                    handleLikeTapped()
                } label: {
                    Image(systemName: didLike ? "heart.fill" : "heart")
                        .foregroundStyle(didLike ? .red : .secondary)
                }
                Button {
                    showTableTalkSheet.toggle()
                } label: {
                    Image(systemName: "bubble.right")
                }
                Button {
                    
                } label: {
                    Image(systemName: "arrow.rectanglepath")
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "paperplane")
                }
            }
            HStack(spacing: 4) {
                if gamble.likes > 0 {
                    Text("\(gamble.likes) likes")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .padding(.vertical, 4)
                }
                
                if gamble.likes > 0 && gamble.tableTalkCount > 0 {
                    Text("-")
                }
                
                if gamble.tableTalkCount > 0 {
                    Text("\(gamble.tableTalkCount) replies")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .padding(.vertical, 4)
                }
            }
        }
        .sheet(isPresented: $showTableTalkSheet) {
            TableTalkView(gamble: gamble)
        }
    }
}

#Preview {
    ContentActionButtonsView(gamble: DeveloperPreview.shared.gamble)
}
