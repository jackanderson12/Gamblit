//
//  GenericChartView.swift
//  Gamblit
//
//  Created by Jack Anderson on 2/1/24.
//

import SwiftUI
import Charts

struct GenericPointChartView<DataPoint: PlottableDataPoint>: View {
    var dataPoints: [DataPoint]
    var chartYaxis: [Double]?
    
    // Calculate y domain values separately
    private var domain: (Double, Double) {
        return (dataPoints.map{ $0.value }.min() ?? 0, dataPoints.map{ $0.value }.max() ?? 1)
    }
    
    // Find min/max date and add padding (1 day)
    private var minDate: Date {
        guard let minimumDate = dataPoints.map({ $0.date }).min() else { return Date() }
        return Calendar.current.date(byAdding: .day, value: -1, to: minimumDate) ?? minimumDate
    }
    
    private var maxDate: Date {
        guard let maximumDate = dataPoints.map({ $0.date }).max() else { return Date() }
        return Calendar.current.date(byAdding: .day, value: 1, to: maximumDate) ?? maximumDate
    }
    
    var body: some View {
        Chart(dataPoints) { point in
            LineMark(x: .value("date", point.date), y: .value("points", point.value))
                .foregroundStyle(.blue)
                .opacity(0.5)
                .symbol(.circle)
                .symbolSize(150)
                .interpolationMethod(.catmullRom)
            PointMark(x: .value("date", point.date), y: .value("points", point.value))
                .foregroundStyle(.blue)
                .opacity(0.5)
                .symbol(.circle)
                .symbolSize(150)
                .annotation(position: .top) {
                    Text(String(format: "%.0f", point.value))
                        .font(.caption)
                }
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: .day))
        }
        .chartXScale(domain: minDate...maxDate)
        .chartYScale(domain: (domain.0 - 5)...(domain.1 + 5))
        .padding(.all)
        .frame(minHeight: 300)
    }
}

#Preview {
    GenericPointChartView(dataPoints: [DataPoint(date: Date(), value: 1.0)], chartYaxis: [0,1,2])
}
