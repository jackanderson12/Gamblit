//
//  HistoricalPickerView.swift
//  Gamblit
//
//  Created by Jack Anderson on 1/25/24.
//

import SwiftUI

struct HistoricalPickerView: View {
    
    @Binding var selectedDate: Date
    
    var body: some View {
        VStack {
            DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .frame(maxHeight: 400)
        }
    }
}
