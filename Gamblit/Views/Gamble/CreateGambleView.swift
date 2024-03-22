//
//  CreateGambleView.swift
//  Gamblit
//
//  Created by Jack Anderson on 2/25/24.
//

import SwiftUI

struct CreateGambleView: View {
    
    @StateObject var profileViewModel: ProfileViewModel
    
    var game: Game
    
    @State private var userId: String = ""
    @State private var gambleTitle: String = ""
    @State private var gambleDescription: String = ""
//    @State private var sportsbooks: String = ""
    
    @State private var navigateToFeed: Bool = false
    
    var body: some View {
        VStack {
            EventCardView(book: game.bookmakers!.first!)
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
                    try? await GambleManager.shared.uploadGamble(gamble: Gamble(id: String("\(UUID())"), userId: userId, game: game, title: gambleTitle, description: gambleDescription, likes: 1))
                }
            }
            .buttonStyle(.borderedProminent)
            .onSubmit {
                navigateToFeed = true
            }
            .padding(.bottom)
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

//#Preview {
//    CreateGambleView(profileViewModel: ProfileViewModel(), game: Game(id: "", commenceTime: "", homeTeam: "", awayTeam: "", sportKey: "", sportTitle: "", bookmakers: []))
//}
