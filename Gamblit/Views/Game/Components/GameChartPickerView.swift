//
//  GameChartPickerView.swift
//  Gamblit
//
//  Created by Jack Anderson on 1/20/24.
//

import SwiftUI

struct GameChartPickerView: View {
    
    @StateObject var viewModel: GamesViewModel
    
    @State private var selectedDate: String? = ISO8601DateFormatter().string(from: Date())
    
    private var dateOptions: [String] {
        let dateFormatter = ISO8601DateFormatter()
        
        var dates = [
            Date(),
            Calendar.current.date(byAdding: .day, value: -3, to: Date())!,
            Calendar.current.date(byAdding: .day, value: -5, to: Date())!
        ].map { dateFormatter.string(from: $0) }
        
        dates.insert("Now", at: 0)
        
        return dates
    }
    
    var body: some View {
        Picker("Filter Chart Dates", selection: $selectedDate) {
            ForEach(dateOptions, id: \.self) { dateStr in
                Text(dateStr).tag(dateStr as String?)
            }
        }
        .pickerStyle(.segmented)
        .onChange(of: selectedDate) {
            print("New Date Selected: \(selectedDate ?? "No Value")")
            viewModel.selectedDate = selectedDate
        }
        .onAppear {
            viewModel.selectedDate = selectedDate
        }
    }
}

#Preview {
    GameChartPickerView(viewModel: GamesViewModel(GamesManager()))
}
