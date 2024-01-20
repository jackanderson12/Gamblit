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
            if coordinates.count <= 2 {
                ForEach(coordinates, id: \.?.0) { item in
                    if let time = item?.0, let value = item?.1 {
                        PointMark(
                            x: .value("Time", time),
                            y: .value("Value", value)
                        )
                    }
                }
            } else {
                ForEach(coordinates, id: \.?.0) { item in
                    if let time = item?.0, let value = item?.1 {
                        LineMark(
                            x: .value("Time", time),
                            y: .value("Value", value)
                        )
                    }
                }
            }
        }
    }
}


#Preview {
    ChartView(coordinates: [(Date(), 150.5)])
}
