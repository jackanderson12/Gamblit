//
//  ProfileView.swift
//  Gamblit
//
//  Created by Jack Anderson on 12/14/23.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    @Binding var showSignInView: Bool
    
    let sportsBooks: [String] = ["Draft Kings", "Fanduel", "Bet MGM", "Caesars"]
    private func sportsBookIsSelected(sportsBook: String) -> Bool{
        viewModel.user?.sportsBooks?.contains(sportsBook) == true
    }
    
    var body: some View {
        List {
            if let user = viewModel.user {
                Text("UserId: \(user.userId)")
                
                if let isAnonymous = user.isAnonymous {
                    Text("Is Anonymous: \(isAnonymous.description.capitalized)")
                }
                
                Button(action: {
                    viewModel.togglePremiumStatus()
                }, label: {
                    Text("User is premium: \((user.isPremium ?? false).description.capitalized)")
                })
                
                VStack{
                    HStack {
                        ForEach(sportsBooks, id: \.self) { book in
                            Button(book) {
                                if sportsBookIsSelected(sportsBook: book) {
                                    viewModel.removeUserSportsBooks(sportsBooks: book)
                                } else {
                                    viewModel.addUserSportsBooks(sportsBooks: book)
                                }
                            }
                            .font(.headline)
                            .buttonStyle(.borderedProminent)
                            .tint(sportsBookIsSelected(sportsBook: book) ? .green : .red)
                        }
                    }
                    Text("User Sports Books: \((user.sportsBooks  ?? []).joined(separator: ", "))")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .task {
            try? await viewModel.loadCurrentUser()
        }
        .navigationTitle("Profile")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    SettingsView(showSignInView: $showSignInView)
                } label: {
                    Image(systemName: "gear")
                        .font(.headline)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}
