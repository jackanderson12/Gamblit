//
//  SettingsView.swift
//  Gamblit
//
//  Created by Jack Anderson on 12/14/23.
//

import SwiftUI
import FirebaseAuth

struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        List {
            Button("Sign Out") {
                Task {
                    do {
                        try viewModel.signOut()
                        showSignInView = true
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            Button(role: .destructive) {
                Task {
                    do {
                        try await viewModel.deleteAccount()
                        showSignInView = true
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            } label: {
                Text("Delete Account")
            }
            
            if viewModel.authUser?.isAnonymous == true {
                anonymousSection
            }
        }
        .onAppear {
            viewModel.loadAuthProviders()
            viewModel.loadAuthUser()
        }
        .navigationTitle("Settings")
    }
}

extension SettingsView {
    
    private var anonymousSection: some View {
        Section {
            Button("Link Google Account") {
                Task {
                    do {
                        try await viewModel.linkGoogleAccount()
                        print("Google Linked!")
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            Button("Link Apple Account") {
                Task {
                    do {
                        try await viewModel.linkAppleAccount()
                        print("Apple Linked!")
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        } 
        header: {
            Text("Create Account")
        }
    }
}

