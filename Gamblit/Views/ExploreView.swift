//
//  ExploreView.swift
//  Gamblit
//
//  Created by Jack Anderson on 3/27/24.
//

import SwiftUI

struct ExploreView: View {
    
    @StateObject private var viewModel = ExploreViewModel()
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.users) {  user in
                        NavigationLink(value: user) {
                            VStack {
                                UserCellView(user: user)
                                
                                Divider()
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }
            .navigationDestination(for: DBUser.self, destination: { user in
                UserProfileView(user: user)
            })
            .searchable(text: $searchText, prompt: "Search")
            .navigationTitle("Search")
        }
    }
}

#Preview {
    ExploreView()
}
