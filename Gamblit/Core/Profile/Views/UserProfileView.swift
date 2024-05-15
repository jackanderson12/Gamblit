//
//  UserProfileView.swift
//  Gamblit
//
//  Created by Jack Anderson on 4/1/24.
//

import SwiftUI

struct UserProfileView: View {
    
    let user: DBUser
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                UserProfileHeaderView(user: user)
                
                Button {
                    
                } label: {
                    Text("Follow")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.background)
                        .frame(width: 352, height: 32)
                        .background(.foreground)
                        .clipShape(.buttonBorder)
                }
                
                //User Content List View
                UserContentListView(user: user)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal)
    }
}

#Preview {
    UserProfileView(user: DeveloperPreview.shared.user)
}
