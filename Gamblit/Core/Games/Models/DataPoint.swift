//
//  DataPoint.swift
//  Gamblit
//
//  Created by Jack Anderson on 2/8/24.
//

import Foundation

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
