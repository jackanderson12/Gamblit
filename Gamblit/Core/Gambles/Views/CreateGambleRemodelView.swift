//
//  CreateGambleRemodelView.swift
//  Gamblit
//
//  Created by Jack Anderson on 4/2/24.
//

import SwiftUI

struct CreateGambleRemodelView: View {
    
    @StateObject var viewModel = GambleViewModel()
    @Environment(\.dismiss) var dismiss
    
    let game: Game
    let bookmakers: [Bookmakers]
    
    private var currentUser: DBUser? {
        return UserManager.shared.currentUser
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .top) {
                        CircularProfileImageView(user: currentUser, size: .small)
                            .padding(.leading, 10)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(currentUser?.username ?? "")
                                .fontWeight(.semibold)
                            
                            TextField("Start a Gamble...", text: $viewModel.title, axis: .vertical)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.bottom, 10)
                            
                        }
                        .font(.footnote)
                    }
                    
                    VStack(spacing: 15) {
                        ForEach(bookmakers, id: \.self) { book in
                            VStack(spacing: 5) {
                                Text(book.key?.capitalized ?? "")
                                    .font(.subheadline)
                                GambleCardComponentView(game: game, bookmaker: book)
                                    .padding(.horizontal)
                            }
                        }
                    }
                    
                    Spacer()
                }
            }
            .navigationTitle("New Gamble")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Post") {
                        Task {
                            try await viewModel.uploadGamble()
                            dismiss()
                        }
                    }
                    .opacity(viewModel.title.isEmpty ? 0.5 : 1.0)
                    .disabled(viewModel.title.isEmpty)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
                }
            }
            .onAppear {
                viewModel.game = game
                viewModel.bookmakers = bookmakers
            }
        }
    }
}

#Preview {
    CreateGambleRemodelView(game: DeveloperPreview.shared.game, bookmakers: DeveloperPreview.shared.bookmakers)
}
