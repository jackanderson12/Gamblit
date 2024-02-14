//
//  EventCardView.swift
//  Gamblit
//
//  Created by Jack Anderson on 1/25/24.
//

import SwiftUI

struct EventCardView: View {
    
    var book: Bookmakers
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                .foregroundStyle(.green)
                .opacity(0.5)
            HStack(alignment: .center, spacing: 2) {
                ForEach(book.markets ?? [], id:\.key) { market in
                    VStack(alignment: .center, spacing: 2) {
                        Text("\(market.key?.capitalized ?? "")")
                            .fontWeight(.black)
                            .padding(.all)
                        ForEach(market.outcomes ?? [], id:\.name) { outcome in
                            if let name = outcome.name {
                                Text(name.capitalized)
                                    .multilineTextAlignment(.center)
                                    .fontWeight(.bold)
                                    .padding(.horizontal)
                            }
                            if let price = outcome.price {
                                Text("\(price, specifier: "%.2f")")
                                    .padding(.horizontal)
                            }
                            if let point = outcome.point {
                                Text("\(point, specifier: "%.1f")")
                                    .padding(.horizontal)
                            }
                        }
                    }
                }
            }
            .frame(maxHeight: 300)
        }
    }
}

#Preview {
    EventCardView(book: Bookmakers(key: "", title: "", lastUpdate: "", markets: []))
}
