//
//  BookmakersButtonsView.swift
//  Gamblit
//
//  Created by Jack Anderson on 1/20/24.
//

import SwiftUI

struct BookmakersButtonsView: View {
    @StateObject var viewModel: GamesViewModel
    @State var bookmakers: [Bookmakers]
    
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            Button {
                
            } label: {
                Text("Average")
            }
            .buttonStyle(.borderedProminent)

            ForEach(bookmakers, id: \.key) { bookmaker in
                Button {
                    if let index = viewModel.selectedBooks?.firstIndex(where: { $0.key == bookmaker.key }) {
                        viewModel.selectedBooks?.remove(at: index)
                    } else {
                        viewModel.selectedBooks?.append(bookmaker)
                    }
                } label: {
                    Text("\(bookmaker.title ?? "Unknown")")
                }
                .buttonStyle(.borderedProminent)
                .opacity(viewModel.selectedBooks?.contains(where: { $0.key == bookmaker.key }) == true ? 0.5 : 1.0)
            }
        }
    }
}



#Preview {
    BookmakersButtonsView(viewModel: GamesViewModel(GamesManager()), bookmakers: [])
}
