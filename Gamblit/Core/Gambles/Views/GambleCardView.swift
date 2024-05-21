//
//  GambleCardView.swift
//  Gamblit
//
//  Created by Jack Anderson on 12/12/23.
//

import SwiftUI
import Charts

struct GambleCardView: View {
    let selectedGame: Game
    let selectedBook: [Bookmakers]
    let selectedOutcome: [Outcome]
    
    var body: some View {
        ForEach(selectedBook, id:\.self) { book in
            HStack {
                GambleCardComponentView(game: selectedGame, bookmaker: book)
            }
        }
    }
}

#Preview {
    GambleCardView(selectedGame: DeveloperPreview.shared.game, selectedBook: DeveloperPreview.shared.bookmakers, selectedOutcome: DeveloperPreview.shared.outcomes)
}
