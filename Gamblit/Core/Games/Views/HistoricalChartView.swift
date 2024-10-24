//
//  HistoricalChartView.swift
//  Gamblit
//
//  Created by Jack Anderson on 1/31/24.
//

import SwiftUI
import Charts

struct HistoricalChartView: View {
    
    @StateObject var viewModel: GamesViewModel
    @StateObject var profileViewModel: ProfileViewModel
    var game: Game
    
    @Binding var historicalDetailedDataPoints: [DetailedDataPoint]?
    
    var groupedData: [String: [DetailedDataPoint]] {
        Dictionary(grouping: historicalDetailedDataPoints ?? []) { (dataPoint) -> String in
            "\(dataPoint.book) | \(dataPoint.marketKey) | \(dataPoint.outcomeName)"
        }
    }

    var body: some View {
        ScrollView {
            VStack {
                ForEach(groupedData.keys.sorted(), id: \.self) { key in
                    let dataPoints = groupedData[key] ?? []
                    let priceDataPoints = dataPoints.sorted { $0.date < $1.date }.compactMap { DataPoint(date: $0.date, value: $0.outcomePrice) }
                    let chartPriceYAxisValues = calculateYAxisValues(dataPoints: priceDataPoints)
                    let pointDataPoints = dataPoints.sorted { $0.date < $1.date }.compactMap { dataPoint -> DataPoint? in
                        if let outcomePoint = dataPoint.outcomePoint, outcomePoint != 0 {
                            return DataPoint(date: dataPoint.date, value: outcomePoint)
                        } else {
                            return nil
                        }
                    }
                    let chartPointYAxisValues = calculateYAxisValues(dataPoints: pointDataPoints)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        // Splitting the key to extract book, marketKey, and outcomeName
                        let components = key.split(separator: "|").map { $0.trimmingCharacters(in: .whitespaces) }
                        let title = components.joined(separator: " - ")
                        
                        Text(title)
                            .font(.headline)
                        VStack {
                            if !priceDataPoints.isEmpty {
                                Text("Price Data")
                                    .font(.subheadline)
                                GenericPriceChartView(dataPoints: priceDataPoints, chartYaxis: chartPriceYAxisValues)
                            }
                            if !pointDataPoints.isEmpty {
                                Text("Point Data")
                                    .font(.subheadline)
                                GenericPointChartView(dataPoints: pointDataPoints, chartYaxis: chartPointYAxisValues)
                            }
                        }
                        
                        Divider()
                    }
                }
            }
        }
    }
    
    private func calculateYAxisValues(dataPoints: [DataPoint]) -> [Double]? {
        // Check if the array is empty
        guard !dataPoints.isEmpty else { return nil }

        // Initialize variables to hold the calculation results
        var minimum: Double?
        var maximum: Double?
        var sum: Double = 0

        // Iterate through each data point to perform calculations
        for point in dataPoints {
            if let unwrappedMin = minimum {
                minimum = min(unwrappedMin, point.value)
            } else {
                minimum = point.value
            }
            if let unwrappedMax = maximum {
                maximum = max(unwrappedMax, point.value)
            } else {
                maximum = point.value
            }
            sum += point.value
        }

        // Ensure that at least one non-nil value was processed
        guard let finalMin = minimum, let finalMax = maximum else { return nil }

        // Calculate the average if possible
        let average = sum / Double(dataPoints.compactMap({ $0.value }).count)

        // Return the calculated values
        return [finalMin, average, finalMax]
    }

}
