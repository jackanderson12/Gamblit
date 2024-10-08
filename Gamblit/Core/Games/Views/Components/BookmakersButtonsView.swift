//
//  BookmakersButtonsView.swift
//  Gamblit
//
//  Created by Jack Anderson on 1/20/24.
//

import SwiftUI

struct BookmakersButtonsView: View {
    @StateObject var viewModel: GamesViewModel
    @StateObject var profileViewModel: ProfileViewModel
    
    @Binding var bookmakers: [(String, Bool)]
    @Binding var isAverage: Bool

    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            Button {
                isAverage.toggle()
            } label: {
                Text("Average")
            }
            .buttonStyle(.borderedProminent)
            .tint(isAverage ? .green : .red)
            
            ForEach(bookmakers.indices, id: \.self) { index in
                let bookmaker = bookmakers[index].0
                Button {
                    bookmakers[index].1.toggle()
                    Task {
                        await setBookSelection(book: bookmakers[index].0)
                    }
                } label: {
                    Text(bookmaker)
                }
                .buttonStyle(.borderedProminent)
                .tint(bookmakers[index].1 ? .green : .red)
            }
        }
    }
    
    private func setBookSelection(book: String) async {
        guard viewModel.selectedBooks != nil else {
            return viewModel.selectedBooks = [book]
        }
        if !(viewModel.selectedBooks?.contains(where: { $0 == book }) ?? false) {
            viewModel.selectedBooks?.append(book)
            Task {
                await viewModel.refreshData()
            }
        }
    }
}

