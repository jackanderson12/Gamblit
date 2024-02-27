//
//  GambleCardView.swift
//  Gamblit
//
//  Created by Jack Anderson on 12/12/23.
//

import SwiftUI
import Charts

struct GambleCardView: View {
    
    @Binding var Gamble: Gamble

    var body: some View {
        VStack {
            Text(Gamble.title) //Placeholder for what to place here
                .font(.headline)

            //ChartView()
                //.frame(height: 100) // Adjust as needed

            Text(Gamble.description)
                .font(.body)
                .lineLimit(1)
                .truncationMode(.tail)

            HStack {
                Button(action: {
                    // Handle like action
                }) {
                        Image(systemName: "arrow.up")
                }
                Text("\(Gamble.likes)")
                Button(action: {
                    // Handle dislike action
                }) {
                    Image(systemName: "arrow.down")
                }

                Button(action: {
                    // Handle comment action
                }) {
                    Image(systemName: "message")
                }
            }
        }
        .padding()
        .cornerRadius(15)
        .shadow(radius: 10)
    }
}

//#Preview {
//    GambleCardView(Gamble: <#Binding<Gamble>#>)
//}
