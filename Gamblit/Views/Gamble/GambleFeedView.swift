//
//  GambleFeedView.swift
//  Gamblit
//
//  Created by Jack Anderson on 2/25/24.
//

import SwiftUI

struct GambleFeedView: View {
    
    @StateObject private var viewModel = GambleFeedViewModel()
    @StateObject private var gambleDetailViewModel = GambleDetailViewModel()
    @StateObject var profileViewModel: ProfileViewModel
    
    @State private var gambles: [Gamble] = []
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach($gambles, id: \.id) { gamble in
                        NavigationLink {
                            GambleDetailView(viewModel: gambleDetailViewModel, profileViewModel: profileViewModel, gamble: gamble)
                        } label: {
                            GambleCardView(viewModel: gambleDetailViewModel, profileViewModel: profileViewModel, gamble: gamble)
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
}

