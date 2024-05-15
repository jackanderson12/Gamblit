//
//  UserContentListView.swift
//  Gamblit
//
//  Created by Jack Anderson on 4/25/24.
//

import SwiftUI

struct UserContentListView: View {
    
    @StateObject var viewModel: UserContentListViewModel
    @State private var selectedFilter: ProfileGambleFilter = .gambles
    @Namespace var animation
    
    private var filterBarWidth: CGFloat {
        let count = CGFloat(ProfileGambleFilter.allCases.count)
        return (UIScreen.current?.bounds.size.width)! / count - 16
    }
    
    init(user: DBUser) {
        self._viewModel = StateObject(wrappedValue: UserContentListViewModel(user: user))
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
                switch selectedFilter {
                case .gambles:
                    ForEach(viewModel.gambles) { gamble in
                        GambleCellView(gamble: gamble)
                            .transition(.move(edge: .leading))
                    }
                case .tabletalks:
                    ForEach(viewModel.tableTalks) { tableTalk in
                        GambleTableTalksProfileCell(tableTalk: tableTalk)
                            .transition(.move(edge: .trailing))
                    }
                }
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    UserContentListView(user: DeveloperPreview.shared.user)
}
