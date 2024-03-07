//
//  CreateGambleView.swift
//  Gamblit
//
//  Created by Jack Anderson on 2/25/24.
//

import SwiftUI

struct CreateGambleView: View {
    
    @StateObject var profileViewModel: ProfileViewModel
    
    @State private var userId: String = ""
    @State private var gambleTitle: String = ""
    @State private var gambleDescription: String = ""
    @State private var sportsbooks: [String] = []
    
    var body: some View {
        VStack {
            Form {
                Section("Title") {
                    TextField("Title", text: $gambleTitle)
                }
                Section("Description") {
                    TextField("Description", text: $gambleDescription)
                }
            }
            Button("Post") {
                Task {
                    try? await GambleManager.shared.uploadGamble(gamble: Gamble(id: String("\(UUID())"), userId: userId, sportsBooks: profileViewModel.user!.sportsBooks!, title: gambleTitle, description: gambleDescription, likes: 1, tableTalk: []))
                }
            }
        }
        .task {
            do {
                try await profileViewModel.loadCurrentUser()
                userId = profileViewModel.user!.userId
            } catch {
                
            }
        }
    }
}

#Preview {
    CreateGambleView(profileViewModel: ProfileViewModel())
}
