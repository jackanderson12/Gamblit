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
    
    private var currentUser: DBUser? {
        return UserManager.shared.currentUser
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(alignment: .top) {
                    CircularProfileImageView(user: currentUser, size: .small)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(currentUser?.userId ?? "")
                            .fontWeight(.semibold)
                        
                        TextField("Start a Gamble...", text: $viewModel.title, axis: .vertical)
                    }
                    .font(.footnote)
                    
                    Spacer()
                    
                    if !viewModel.title.isEmpty {
                        Button {
                            viewModel.title = ""
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 12, height: 12)
                                .foregroundStyle(.gray)
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("New Gamble")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("cancel") {
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
        }
    }
}

#Preview {
    CreateGambleRemodelView()
}
