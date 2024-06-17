//
//  GambleCardView.swift
//  Gamblit
//
//  Created by Jack Anderson on 12/12/23.
//

import SwiftUI
import Charts

struct GambleCardView: View {
    
    let gamble: Gamble
    
    var body: some View {
        VStack {
            Text(gamble.title)
                .font(.subheadline)
            ForEach(gamble.bookmakers, id:\.self) { book in
                HStack {
                    GambleCardComponentView(game: gamble.game, bookmaker: book)
                }
            }
        }
    }
}

#Preview {
    GambleCardView(gamble: DeveloperPreview.shared.gamble)
}
