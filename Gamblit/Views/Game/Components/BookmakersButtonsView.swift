//
//  BookmakersButtonsView.swift
//  Gamblit
//
//  Created by Jack Anderson on 1/20/24.
//

import SwiftUI

struct BookmakersButtonsView: View {
    
    @StateObject var viewModel: GamesViewModel
    
    @State var bookmakers: [String?]

    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            Button {
                // Logic for "Average" button
            } label: {
                Text("Average")
            }
            .buttonStyle(.borderedProminent)

            ForEach(bookmakers, id: \.self) { bookmaker in
                Button {
                    if let bookmakerName = bookmaker {
                        if viewModel.selectedBooks?.contains(bookmakerName) == true {
                            viewModel.selectedBooks?.removeAll { $0 == bookmakerName }
                        } else {
                            viewModel.selectedBooks?.append(bookmakerName)
                        }
                    }
                } label: {
                    Text(bookmaker ?? "Unknown")
                }
                .buttonStyle(.borderedProminent)
                .tint(viewModel.selectedBooks?.contains(bookmaker ?? "") == true ? .red : .green)
            }
        }
    }
}




#Preview {
    BookmakersButtonsView(viewModel: GamesViewModel(GamesManager()), bookmakers: [])
}
