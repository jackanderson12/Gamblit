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

            Text(Gamble.title)
                .font(.title2)
                .lineLimit(1)
                .truncationMode(.tail)

            Text(Gamble.description)
                .font(.body)
                .lineLimit(1)
                .truncationMode(.tail)

            HStack {
                Button(action: {
                    // Handle like action
                }) {
                    HStack{
                        Image(systemName: "arrow.up")
                        Text("\(Gamble.likes)")
                    }
                }

                Button(action: {
                    // Handle dislike action
                }) {
                    HStack{
                        Image(systemName: "arrow.down")
                        Text("\(Gamble.dislikes)")
                    }
                }

                Button(action: {
                    // Handle comment action
                }) {
                    Image(systemName: "message")
                }
            }
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.width * 0.4)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 10)
    }
}

//#Preview {
//    GambleCardView(Gamble: <#Binding<Gamble>#>)
//}
