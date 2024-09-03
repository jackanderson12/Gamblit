//
//  BookmakerView.swift
//  Gamblit
//
//  Created by Jack Anderson on 8/21/24.
//

import SwiftUI

struct BookmakerView: View {
    let book: Bookmakers
    let game: Game
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        VStack {
            Text("\(book.title?.capitalized ?? "Book Name")")
                .font(.headline)
                .fontWeight(.black)
                .padding(.vertical, 10)
            EventCardView(game: game, bookmaker: book)
                .background(isSelected ? Color.green.opacity(0.3) : Color.clear)
                .clipShape(.rect(cornerRadius: 4))
                .onTapGesture {
                    onTap()
                }
        }
    }
}
