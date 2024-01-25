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

//#Preview {
//    GameChartPickerView()
//}


//    @State private var selectedDate: String? = ISO8601DateFormatter().string(from: Date())
//
//    private var dateOptions: [String] {
//        let dateFormatter = ISO8601DateFormatter()
//
//        var dates = [
//            Date(),
//            Calendar.current.date(byAdding: .day, value: -3, to: Date())!,
//            Calendar.current.date(byAdding: .day, value: -5, to: Date())!
//        ].map { dateFormatter.string(from: $0) }
//
//        dates.insert("Now", at: 0)
//
//        return dates
//    }
