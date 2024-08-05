//
//  UserProfileHeaderView.swift
//  Gamblit
//
//  Created by Jack Anderson on 4/25/24.
//

import SwiftUI

struct UserProfileHeaderView: View {
    var user: DBUser?
    
    init(user: DBUser?) {
        self.user = user
    }
    
    var body: some View {
        HStack(alignment: .top) {
            //Bio and Stats
            VStack(alignment: .leading, spacing: 12) {
                //Full Name and Username
                VStack(alignment: .leading, spacing: 4) {
                    Text(user?.username ?? "")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    if user?.bio != nil {
                        Text(user?.bio ?? "")
                            .font(.subheadline)
                    }
                }
                
                if let books = user?.sportsBooks {
                    ScrollView(.horizontal) {
                        HStack{
                            ForEach(books, id: \.self) { book in
                                Text(book)
                                    .font(.footnote)
                            }
                        }
                    }
                }
                
                Text("2 Followers")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            CircularProfileImageView(user: user, size: .medium)
        }
    }
}

#Preview {
    UserProfileHeaderView(user: DeveloperPreview.shared.user)
}
