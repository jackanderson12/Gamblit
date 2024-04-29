//
//  UserCell.swift
//  Gamblit
//
//  Created by Jack Anderson on 3/27/24.
//

import SwiftUI

struct UserCellView: View {
    let user: DBUser
    
    var body: some View {
        HStack {
            CircularProfileImageView(user: user, size: .small)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(user.userId!)
                    .fontWeight(.semibold)
                
                Text(user.userId!)
            }
            .font(.footnote)
            
            Spacer()
            
            Text("Follow")
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(width: 100, height: 32)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray), lineWidth: 1)
                }
        }
        .padding(.horizontal)
    }
}

#Preview {
    UserCellView(user: DeveloperPreview.shared.user)
}
