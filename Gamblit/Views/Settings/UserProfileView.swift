//
//  UserProfileView.swift
//  Gamblit
//
//  Created by Jack Anderson on 4/1/24.
//

import SwiftUI

struct UserProfileView: View {
    
    @State private var selectedFilter: ProfileGambleFilter = .gambles
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HStack(alignment: .top) {
                    //Bio and Stats
                    VStack(alignment: .leading, spacing: 12) {
                        //Full Name and Username
                        VStack(alignment: .leading, spacing: 4) {
                            Text("First Last")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            Text("username1")
                                .font(.subheadline)
                            
                        }
                        
                        Text("Insert bio stuff here")
                            .font(.footnote)
                        
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
                                
                            }
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    UserProfileView()
}
