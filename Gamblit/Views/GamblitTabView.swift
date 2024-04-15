//
//  GamblitTabView.swift
//  Gamblit
//
//  Created by Jack Anderson on 4/2/24.
//

import SwiftUI

struct GamblitTabView: View {
    
    @State private var showCreateGambleView = false
    @State private var selectedTab = 0
    
    var body: some View {
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
            CurrentUserProfileView()
                .tabItem {
                    Image(systemName: selectedTab == 3 ? "person.fill" : "person")
                        .environment(\.symbolVariants, selectedTab == 3 ? .fill : .none)
                }
                .onAppear {
                    selectedTab = 4
                }
                .tag(4)
        }
        .onChange(of: selectedTab, {
            showCreateGambleView = selectedTab == 2
        })
        .sheet(isPresented: $showCreateGambleView, onDismiss: {
            selectedTab = 0
        }, content: {
            CreateGambleRemodelView()
        })
    }
}

#Preview {
    GamblitTabView()
}
