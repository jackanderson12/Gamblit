//
//  GambleFeedView.swift
//  Gamblit
//
//  Created by Jack Anderson on 2/25/24.
//

import SwiftUI

struct GambleFeedView: View {
    
    @StateObject private var viewModel = GambleFeedViewModel()
    
    @State private var gambles: [Gamble] = []
    
    var body: some View {
        NavigationStack {
            VStack {
                ForEach($gambles, id: \.id) { gamble in
                    GambleCardView(Gamble: gamble)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    CreateGambleView(profileViewModel: ProfileViewModel())
                } label: {
                    Image(systemName: "square.and.pencil")
                }

            }
        }
        .task {
            try? await viewModel.getAllGambles()
            gambles = viewModel.gambles
        }
    }
}

#Preview {
    GambleFeedView()
}
