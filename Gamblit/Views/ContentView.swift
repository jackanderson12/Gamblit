//
//  ContentView.swift
//  Gamblit
//
//  Created by Jack Anderson on 12/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showSignInView = true
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            if !showSignInView {
                TabView {
                    GambleFeedView(profileViewModel: ProfileViewModel())
                        .tabItem {
                            Image(systemName: selectedTab == 0 ? "newspaper.fill" : "newspaper")
                                .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
                        }
                    SportMenuView()
                        .tabItem {
                            Image(systemName: selectedTab == 1 ? "football.fill" : "football")
                                .environment(\.symbolVariants, selectedTab == 1 ? .fill : .none)
                        }
                    ExploreView()
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                        }
                    ProfileView(showSignInView: $showSignInView)
                        .tabItem {
                            Image(systemName: selectedTab == 3 ? "person.fill" : "person")
                                .environment(\.symbolVariants, selectedTab == 3 ? .fill : .none)
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
