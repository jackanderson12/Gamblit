//
//  ContentView.swift
//  Gamblit
//
//  Created by Jack Anderson on 12/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: ContentViewModel = ContentViewModel()

    var body: some View {
        Group {
            if viewModel.userSession != nil {
                GamblitTabView()
            } else {
                AuthenticationView()
            }
        }
    }
}

#Preview {
    ContentView()
}
