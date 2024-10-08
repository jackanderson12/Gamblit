//
//  GambleFeedView.swift
//  Gamblit
//
//  Created by Jack Anderson on 2/25/24.
//

import SwiftUI

struct GambleFeedView: View {
    
    @StateObject private var viewModel = GambleFeedViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(viewModel.gambles, id: \.id) { gamble in
                        NavigationLink(value: gamble) {
                            GambleCellView(gamble: gamble)
                        }
                    }
                }
            }
            .refreshable {
                Task {
                    try await viewModel.fetchGambles()
                }
            }
            .navigationDestination(for: Gamble.self, destination: { gamble in
                GambleDetailView(gamble: gamble, viewModel: GambleDetailViewModel(gamble: gamble))
            })
            .navigationTitle("Gambles")
            .navigationBarTitleDisplayMode(.inline)
        }
        .foregroundStyle(.foreground)
        .padding(.horizontal)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Image(systemName: "arrow.counterclockwise")
            }
        }
    }
}

#Preview {
    GambleFeedView()
}

