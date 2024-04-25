//
//  UserContentListView.swift
//  Gamblit
//
//  Created by Jack Anderson on 4/25/24.
//

import SwiftUI

struct UserContentListView: View {
    
    @State private var selectedFilter: ProfileGambleFilter = .gambles
    @Namespace var animation
    
    private var filterBarWidth: CGFloat {
        let count = CGFloat(ProfileGambleFilter.allCases.count)
        return (UIScreen.current?.bounds.size.width)! / count - 16
    }
    
    var body: some View {
        VStack {
            HStack {
                ForEach(ProfileGambleFilter.allCases) { filter in
                    VStack {
                        Text(filter.title)
                            .font(.subheadline)
                            .fontWeight(selectedFilter == filter ? .semibold : .regular)
                        
                        if selectedFilter == filter {
                            Rectangle()
                                .foregroundStyle(.black)
                                .frame(width: filterBarWidth, height: 1)
                                .matchedGeometryEffect(id: "item", in: animation)
                        } else {
                            Rectangle()
                                .foregroundStyle(.clear)
                                .frame(width: filterBarWidth, height: 1)
                        }
                    }
                    .onTapGesture {
                        withAnimation(.spring()) {
                            selectedFilter = filter
                        }
                    }
                }
            }
            
            LazyVStack {
                ForEach(0 ... 10, id: \.self) { gamble in
                    GambleCellView()
                }
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    UserContentListView()
}
