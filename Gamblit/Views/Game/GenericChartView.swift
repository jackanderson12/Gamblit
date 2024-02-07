//
//  GenericChartView.swift
//  Gamblit
//
//  Created by Jack Anderson on 2/1/24.
//

import SwiftUI
import Charts

protocol PlottableDataPoint: Identifiable {
    var date: Date { get }
    var value: Double { get }
}

struct DataPoint: Identifiable, PlottableDataPoint {
    var id = UUID()
    var date: Date
    var value: Double
}

struct DetailedDataPoint: PlottableDataPoint {
    var id: UUID
    var date: Date
    var value: Double
    
    var book: String
    var marketKey: String
    var outcomeName: String
    var outcomePrice: Double
    var outcomePoint: Double?
}

struct GenericChartView<DataPoint: PlottableDataPoint>: View {
    var dataPoints: [DataPoint]

    var body: some View {
        Chart(dataPoints) { dataPoint in
            if dataPoints.count <= 2 {
                LineMark(
                    x: .value("Date", dataPoint.date),
                    y: .value("Value", dataPoint.value)
                )
                .annotation(position: .top, alignment: .center) {
                    Text("\(dataPoint.value, specifier: "%.2f")")
                        .font(.caption)
                }
            } else {
                PointMark(
                    x: .value("Date", dataPoint.date),
                    y: .value("Value", dataPoint.value)
                )
                .annotation(position: .top, alignment: .center) {
                    Text("\(dataPoint.value, specifier: "%.2f")")
                        .font(.caption)
                }
            }
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: .day))
        }
        .chartYAxis {
            AxisMarks(preset: .automatic)
        }
    }
}



#Preview {
    GenericChartView(dataPoints: [DataPoint(date: Date(), value: 1.0)])
}
