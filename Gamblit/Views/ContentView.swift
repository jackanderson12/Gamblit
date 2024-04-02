//
//  ContentView.swift
//  Gamblit
//
//  Created by Jack Anderson on 12/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showSignInView = true
    @State private var showCreateGambleView = false
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
                        .onAppear {
                            selectedTab = 0
                        }
                        .tag(0)
                    SportMenuView()
                        .tabItem {
                            Image(systemName: selectedTab == 1 ? "football.fill" : "football")
                                .environment(\.symbolVariants, selectedTab == 1 ? .fill : .none)
                        }
                        .onAppear {
                            selectedTab = 1
                        }
                        .tag(1)
                    ProgressView()
                        .tabItem {
                            Image(systemName: "plus")
                        }
                        .onAppear {
                            selectedTab = 2
                        }
                        .tag(2)
                    ExploreView()
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                        }
                        .onAppear {
                            selectedTab = 3
                        }
                        .tag(3)
                    ProfileView(showSignInView: $showSignInView)
                        .tabItem {
                            Image(systemName: selectedTab == 3 ? "person.fill" : "person")
                                .environment(\.symbolVariants, selectedTab == 3 ? .fill : .none)
                        }
                        .onAppear {
                            selectedTab = 4
                        }
                        .tag(4)
                }
            }
        }
        .padding()
        .onAppear {
            let authuser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authuser == nil
        }
        .onChange(of: selectedTab, {
            showCreateGambleView = selectedTab == 2
        })
        .sheet(isPresented: $showCreateGambleView, onDismiss: {
            selectedTab = 0
        }, content: {
            CreateGambleRemodelView()
        })
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
