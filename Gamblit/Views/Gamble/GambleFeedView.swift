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
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach($viewModel.gambles, id: \.id) { gamble in
                        NavigationLink {
                            GambleDetailView(viewModel: gambleDetailViewModel, profileViewModel: profileViewModel, gamble: gamble)
                        } label: {
                            GambleCardView(viewModel: gambleDetailViewModel, profileViewModel: profileViewModel, gamble: gamble)
                        }
                    }
                }
            }
            .refreshable {
                print("DEBUG: Refresh threads")
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

