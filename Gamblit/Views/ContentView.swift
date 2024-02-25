//
//  ContentView.swift
//  Gamblit
//
//  Created by Jack Anderson on 12/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showSignInView = true
    
    var body: some View {
        NavigationStack {
            ZStack {
                if !showSignInView {
                    NavigationStack {
                        TabView {
                            GambleFeedView()
                                .tabItem {
                                    Image(systemName: "newspaper.fill")
                                }
                            CreateGambleView()
                                .tabItem {
                                    Image(systemName: "square.and.pencil")
                                }
                            SportMenuView()
                                .tabItem {
                                    Image(systemName: "football.fill")
                                }
                            ProfileView(showSignInView: $showSignInView)
                                .tabItem {
                                    Image(systemName: "person.fill")
                                }
                        }
                    }
                }
            }
        }
        .padding()
        .onAppear {
            let authuser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authuser == nil
        }
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack {
                AuthenticationView(showSignInView: $showSignInView)
            }
        }
    }
}

#Preview {
    ContentView()
}
