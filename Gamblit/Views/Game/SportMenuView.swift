//
//  SportMenuView.swift
//  Gamblit
//
//  Created by Jack Anderson on 12/22/23.
//

import SwiftUI

struct SportMenuView: View {
    @StateObject private var viewModel = GamesViewModel(GamesManager())
    
    var body: some View {
        ZStack {
            List(Sport.allCases, id: \.self) { sport in
                NavigationLink {
                    GamesView(viewModel: viewModel)
                } label: {
                    Text(sport.rawValue)
                }
                .simultaneousGesture(TapGesture().onEnded {
                    viewModel.selectedSport = sport
                })
            }
        }
    }
}

#Preview {
    SportMenuView()
}
