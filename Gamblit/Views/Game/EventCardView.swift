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
            HStack {
                ForEach(book.markets ?? [], id:\.key) { market in
                    VStack(alignment: .center, spacing: 8) {
                        Text("\(market.key ?? "")")
                        ForEach(market.outcomes ?? [], id:\.name) { outcome in
                            if let name = outcome.name {
                                Text("\(name)")
                            }
                            if let price = outcome.price {
                                Text("\(price)")
                            }
                            if let point = outcome.point {
                                Text("\(point)")
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    EventCardView(book: Bookmakers(key: "", title: "", lastUpdate: "", markets: []))
}
