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

    // Adjusted to include outcomeName in the grouping key
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
                    let priceDataPoints = dataPoints.compactMap { DataPoint(date: $0.date, value: $0.outcomePrice) }
                    let pointDataPoints = dataPoints.compactMap { DataPoint(date: $0.date, value: $0.outcomePoint ?? 0) }
                    
                    VStack(alignment: .leading, spacing: 20) {
                        // Splitting the key to extract book, marketKey, and outcomeName
                        let components = key.split(separator: "|").map { $0.trimmingCharacters(in: .whitespaces) }
                        let title = components.joined(separator: " - ")
                        
                        Text(title)
                            .font(.headline)
                        if !priceDataPoints.isEmpty {
                            Text("Price Data")
                                .font(.subheadline)
                            GenericChartView(dataPoints: priceDataPoints)
                        }
                        if !pointDataPoints.isEmpty {
                            Text("Point Data")
                                .font(.subheadline)
                            GenericChartView(dataPoints: pointDataPoints)
                        }
                    }
                }
            }
        }
    }
}


//#Preview {
//    HistoricalChartView(viewModel: GamesViewModel(GamesManager()), profileViewModel: ProfileViewModel(), game: Game(id: "", commenceTime: "", homeTeam: "", awayTeam: "", sportKey: "", sportTitle: "", bookmakers: []), historicalDetailedDataPoints: [])
//}
