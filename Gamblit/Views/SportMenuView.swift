//
//  SportMenuView.swift
//  Gamblit
//
//  Created by Jack Anderson on 12/22/23.
//

import SwiftUI

struct SportMenuView: View {
    @StateObject private var viewModel = SportMenuViewModel()
    var body: some View {
        ZStack {
            VStack {
                ForEach(viewModel.sports, id: \.self) { sport in
                    Button(action: {
                        
                    }, label: {
                        Text("\(sport)")
                            .font(.system(size: 20)).bold()
                            .padding(1)
                    })
                }
            }
        }
    }
}

#Preview {
    SportMenuView()
}
