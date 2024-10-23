//
//  GenericChartView.swift
//  Gamblit
//
//  Created by Jack Anderson on 2/1/24.
//

import SwiftUI
import Charts

struct GenericPriceChartView<DataPoint: PlottableDataPoint>: View {
    var dataPoints: [DataPoint]
    var chartYaxis: [Double]?
    
    // Filter positive and negative points
    private var positivePoints: [DataPoint] {
        dataPoints.filter { $0.value >= 100 }
    }
    private var negativePoints: [DataPoint] {
        dataPoints.filter { $0.value <= -100 }
    }
    
    // Find min/max of y-values for dynamic scaling
    private var maxPositiveValue: Double {
        positivePoints.map { $0.value }.max() ?? 100
    }
    private var minNegativeValue: Double {
        negativePoints.map { $0.value }.min() ?? -100
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
        VStack(spacing: 0) {
            // Positive points chart
            Chart(positivePoints) { point in
                LineMark(x: .value("date", point.date), y: .value("odds", point.value))
                    .foregroundStyle(.green)
                    .opacity(0.5)
                    .symbol(.circle)
                    .symbolSize(150)
                    .interpolationMethod(.catmullRom)
                PointMark(x: .value("date", point.date), y: .value("odds", point.value))
                    .foregroundStyle(.green)
                    .opacity(0.5)
                    .symbol(.circle)
                    .symbolSize(150)
                    .annotation(position: .top) {
                        Text(String(format: "%+.0f", point.value)) // Include the + for positive numbers
                            .font(.caption)
                    }
            }
            .chartXAxis { // Hide the x-axis on the first chart
                AxisMarks { value in
                    AxisGridLine()
                    AxisTick()
                }
            }
            .chartYAxis {
                AxisMarks { value in
                    AxisGridLine()
                    AxisTick()
                    AxisValueLabel {
                        if let yValue = value.as(Double.self) {
                            Text("+\(Int(yValue))")
                        }
                    }
                }
            }
            .chartXScale(domain: minDate...maxDate) // Shared X-Axis range
            .chartYScale(domain: 100...(maxPositiveValue + 20)) // Dynamic Y-Axis for positive values
            .frame(height: 150)
            
            // Negative points chart
            Chart(negativePoints) { point in
                LineMark(x: .value("date", point.date), y: .value("odds", point.value))
                    .foregroundStyle(.red)
                    .opacity(0.5)
                    .symbol(.circle)
                    .symbolSize(150)
                    .interpolationMethod(.catmullRom)
                PointMark(x: .value("date", point.date), y: .value("odds", point.value))
                    .foregroundStyle(.red)
                    .opacity(0.5)
                    .symbol(.circle)
                    .symbolSize(150)
                    .annotation(position: .bottom) {
                        Text(String(format: "%.0f", point.value)) // Include the + for positive numbers
                            .font(.caption)
                    }
            }
            .chartXAxis {
                AxisMarks(values: .stride(by: .day))
            }
            .chartXScale(domain: minDate...maxDate) // Shared X-Axis range
            .chartYAxis {
                AxisMarks { value in
                    AxisGridLine()
                    AxisTick()
                    AxisValueLabel {
                        if let yValue = value.as(Double.self) {
                            Text("\(Int(yValue))")
                        }
                    }
                }
            }
            .chartYScale(domain: (minNegativeValue - 20)...(-100)) // Dynamic Y-Axis for negative values
            .frame(height: 150)
        }
    }
}

#Preview {
    GenericPriceChartView(dataPoints: [DataPoint(date: Date(), value: 1.0)], chartYaxis: [0,1,2])
}
