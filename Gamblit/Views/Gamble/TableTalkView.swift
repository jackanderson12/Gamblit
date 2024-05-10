//
//  TableTalkView.swift
//  Gamblit
//
//  Created by Jack Anderson on 5/9/24.
//

import SwiftUI

struct TableTalkView: View {
    
    let gamble: Gamble
    @State private var tableTalkText = ""
    @State private var gambleViewHeight: CGFloat = 24
    @Environment(\.dismiss) var dismiss
    
    private var currentUser: DBUser? {
        return UserManager.shared.currentUser
    }
    
    func setGambleViewHeight() {
        let imageDimension: CGFloat = ProfileImageSize.small.dimension
        let padding: CGFloat = 16
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Divider()
                VStack(alignment: .leading, spacing: 12) {
                    HStack(alignment: .top) {
                        VStack {
                            CircularProfileImageView(user: gamble.user, size: .small)
                            
                            Rectangle()
                                .frame(width: 2, height: 50)
                                .foregroundStyle(.secondary)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(gamble.user?.id ?? "")
                                .fontWeight(.semibold)
                            
                            Text(gamble.title)
                                .multilineTextAlignment(.leading)
                        }
                        .font(.footnote)
                        
                        Spacer()
                    }
                    
                    HStack(alignment: .top){
                        CircularProfileImageView(user: currentUser, size: .small)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(currentUser?.id ?? "")
                            
                            TextField("Add your reply...", text: $tableTalkText, axis: .vertical)
                                .multilineTextAlignment(.leading)
                        }
                        .font(.footnote)
                    }
                }
                .padding()
            }
            .navigationTitle("Table Talk")
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
                            //try await viewModel.uploadGamble()
                            dismiss()
                        }
                    }
                    .opacity(tableTalkText.isEmpty ? 0.5 : 1.0)
                    .disabled(tableTalkText.isEmpty)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
                }
            }
        }
    }
}

#Preview {
    TableTalkView(gamble: DeveloperPreview.shared.gamble)
}
