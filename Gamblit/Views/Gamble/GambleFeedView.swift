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
                LazyVStack {
                    ForEach(viewModel.gambles, id: \.id) { gamble in
                        GambleCellView(gamble: gamble)
                    }
                }
            }
            .refreshable {
                Task {
                    try await viewModel.fetchGambles()
                }
            }
            .navigationTitle("Gambles")
            .navigationBarTitleDisplayMode(.inline)
        }
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

