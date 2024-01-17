//
//  ChartView.swift
//  Gamblit
//
//  Created by Jack Anderson on 1/17/24.
//

import SwiftUI
import Charts

struct ChartView: View {
    
    var coordinates: [(Date, Double)?]
    
    var body: some View {
        Chart {
            ForEach(coordinates, id: \.?.0) { coord in
                PointMark(
                    x: .value("Time", coord?.0 ?? Date()),
                    y: .value("Value", coord?.1 ?? 100.0)
                )
            }
        }
        .chartXAxis {
            AxisMarks(preset: .automatic)
        }
        .chartYAxis {
            AxisMarks(preset: .automatic)
        }
        .frame(width: 350, height: 225)
    }
}

#Preview {
    ChartView(coordinates: [(Date(), 150.5)])
}
