//
//  ContentActionButtonsView.swift
//  Gamblit
//
//  Created by Jack Anderson on 5/7/24.
//

import SwiftUI

struct ContentActionButtonsView: View {
    @ObservedObject var viewModel: ContentActionButtonsViewModel
    
    init(gamble: Gamble) {
        self.viewModel = ContentActionButtonsViewModel(gamble: gamble)
    }
    
    var body: some View {
        HStack(spacing: 16) {
            Button {
                
            } label: {
                Image(systemName: "heart")
            }

            Button {
                
            } label: {
                Image(systemName: "bubble.right")
            }
            Button {
                
            } label: {
                Image(systemName: "arrow.rectanglepath")
            }

            Button {
                
            } label: {
                Image(systemName: "paperplane")
            }
        }
    }
}

#Preview {
    ContentActionButtonsView()
}
