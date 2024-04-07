//
//  UserProfileView.swift
//  Gamblit
//
//  Created by Jack Anderson on 4/1/24.
//

import SwiftUI

struct UserProfileView: View {
    
    @StateObject var viewModel = ProfileViewModel()
    
    @State private var selectedFilter: ProfileGambleFilter = .gambles
    @Namespace var animation
    
    private var filterBarWidth: CGFloat {
        let count = CGFloat(ProfileGambleFilter.allCases.count)
        return (UIScreen.current?.bounds.size.width)! / count - 16
    }
    
    private var currentUser: DBUser? {
        viewModel.user
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    HStack(alignment: .top) {
                        //Bio and Stats
                        VStack(alignment: .leading, spacing: 12) {
                            //Full Name and Username
                            VStack(alignment: .leading, spacing: 4) {
                                Text(currentUser?.userId ?? "")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                
                                Text(currentUser?.userId ?? "")
                                    .font(.subheadline)
                            }
                            
                            if let books = currentUser?.sportsBooks {
                                ForEach(books, id: \.self) { book in
                                    Text(book)
                                        .font(.footnote)
                                }
                            }
                            
                            Text("2 Followers")
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        
                        Spacer()
                        
                        CircularProfileImageView()
                    }
                    Button {
                        
                    } label: {
                        Text("Follow")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width: 352, height: 32)
                            .background(.black)
                            .clipShape(.buttonBorder)
                    }
                    
                    //User Content List View
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
                        .padding(.vertical, 8)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button {
                        try? AuthenticationManager.shared.signOut()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                    }

                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    UserProfileView()
}
