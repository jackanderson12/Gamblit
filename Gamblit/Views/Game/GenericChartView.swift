//
//  GenericChartView.swift
//  Gamblit
//
//  Created by Jack Anderson on 2/1/24.
//

import SwiftUI
import Charts

struct GenericChartView<DataPoint: PlottableDataPoint>: View {
    var dataPoints: [DataPoint]
    var chartYaxis: [Double]?

    // Calculate domain values separately
    private var domain: (Double, Double) {
        guard let yAxisValues = chartYaxis, let first = yAxisValues.first, let last = yAxisValues.last else {
            return (0, 1)
        }
        return (first, last)
    }

    var body: some View {
        Chart(dataPoints) { dataPoint in
            if dataPoints.count > 2 {
                LineMark(
                    x: .value("Date", dataPoint.date),
                    y: .value("Value", dataPoint.value)
                )
                PointMark(
                    x: .value("Date", dataPoint.date),
                    y: .value("Value", dataPoint.value)
                )
                .annotation(position: .top, alignment: .center) {
                    Text("\(dataPoint.value, specifier: "%.1f")")
                        .font(.footnote)
                        
                }
            } else {
                PointMark(
                    x: .value("Date", dataPoint.date),
                    y: .value("Value", dataPoint.value)
                )
                .annotation(position: .top, alignment: .center) {
                    Text("\(dataPoint.value, specifier: "%.1f")")
                        .font(.footnote)
                }
            }
        }
        .padding(.all)
        .chartXAxis {
            AxisMarks(values: .stride(by: .day))
        }
        .chartYAxis {
            if let yAxisValues = chartYaxis {
                AxisMarks(values: yAxisValues)
            } else {
                AxisMarks(preset: .automatic)
            }
        }
        .chartYScale(domain: domain.0...domain.1)
        .frame(minHeight: 300)
    }
}

#Preview {
    GenericChartView(dataPoints: [DataPoint(date: Date(), value: 1.0)], chartYaxis: [0,1,2])
}
