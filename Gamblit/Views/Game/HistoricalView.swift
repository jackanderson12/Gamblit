//
//  HistoricalView.swift
//  Gamblit
//
//  Created by Jack Anderson on 1/24/24.
//

import SwiftUI

struct HistoricalView: View {
    
    @StateObject var viewModel: GamesViewModel
    
    var body: some View {
        VStack {
            HistoricalPickerView()
            Text("dskaflls")
        }
    }
}

#Preview {
    HistoricalView(viewModel: GamesViewModel(GamesManager()))
}
