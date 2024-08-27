//
//  GameChartPickerView.swift
//  Gamblit
//
//  Created by Jack Anderson on 1/20/24.
//

import SwiftUI

struct GameChartPickerView: View {
    
    @Binding var selectedFilter: apiFilter

    var body: some View {
        Picker("Filter Chart Dates", selection: $selectedFilter) {
            ForEach(apiFilter.allCases, id: \.self) { filter in
                Text(filter.rawValue).tag(filter)
            }
        }
        .pickerStyle(.segmented)
    }
}

