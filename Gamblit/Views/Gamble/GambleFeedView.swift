//
//  GambleFeedView.swift
//  Gamblit
//
//  Created by Jack Anderson on 2/25/24.
//

import SwiftUI

struct GambleFeedView: View {
    
    @StateObject private var viewModel = GambleFeedViewModel()
    @StateObject var profileViewModel: ProfileViewModel
    
    @State private var gambles: [Gamble] = []
    
    var body: some View {
        NavigationStack {
            VStack {
                ForEach($gambles, id: \.id) { gamble in
                    NavigationLink {
                        GambleDetailView(profileViewModel: profileViewModel, gamble: gamble)
                    } label: {
                        GambleCardView(Gamble: gamble)
                    }
                }
            }
            .task {
                try? await viewModel.getAllGambles()
                gambles = viewModel.gambles
            }
        }
    }
}

