//
//  ContentView.swift
//  Gamblit
//
//  Created by Jack Anderson on 12/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showSignInView = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                if !showSignInView {
                    NavigationStack {
                        TabView {
                            SportMenuView()
                                .tabItem {
                                    Image(systemName: "football.fill")
                                }
                            ProfileView(showSignInView: $showSignInView)
                                .tabItem {
                                    Image(systemName: "gear")
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
