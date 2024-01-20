//
//  GambleFromGameChartView.swift
//  Gamblit
//
//  Created by Jack Anderson on 1/18/24.
//

import SwiftUI

struct GambleFromGameChartView: View {
    @Binding var userId: String?
    @Binding var chart: [(Date, Double)?]
    var game: Game
    
    @State private var sportsBooks: [String] = []
    @State private var title: String = ""
    @State private var description: String = ""
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            ChartView(coordinates: chart)
            Form {
                Section {
                    TextField("Title", text: $title)
                } header: {
                    Text("Title")
                }
                
                Section {
                    TextField("Description", text: $description)
                } header: {
                    Text("Description of the Bet")
                }
                
            }
        }
        .navigationTitle("New Gamble")
    }
}

//#Preview {
//    GambleFromGameChartView(userId: .constant("me"), chart: .constant(<#T##value: [(Date, Double)?]##[(Date, Double)?]#>), game: <#Binding<Game>#>)
//}
