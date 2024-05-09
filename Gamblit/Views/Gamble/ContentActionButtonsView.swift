//
//  ContentActionButtonsView.swift
//  Gamblit
//
//  Created by Jack Anderson on 5/7/24.
//

import SwiftUI

struct ContentActionButtonsView: View {
    @ObservedObject var viewModel: ContentActionButtonsViewModel
    
    init(gamble: Gamble) {
        self.viewModel = ContentActionButtonsViewModel(gamble: gamble)
    }
    
    private var didLike: Bool {
        return viewModel.gamble.didLike ?? false
    }
    
    func handleLikeTapped() {
        Task {
            if didLike {
                viewModel.unlikeGamble()
            } else {
                try await viewModel.likeGamble()
            }
        }
    }
    
    var body: some View {
        HStack(spacing: 16) {
            Button {
                handleLikeTapped()
            } label: {
                Image(systemName: didLike ? "heart.fill" : "heart")
                    .foregroundStyle(didLike ? .red : .black)
            }
            Button {
                
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
    }
}

#Preview {
    ContentActionButtonsView(gamble: DeveloperPreview.shared.gamble)
}
