//
//  GambleCellView.swift
//  Gamblit
//
//  Created by Jack Anderson on 3/27/24.
//

import SwiftUI

struct GambleCellView: View {
    let gamble: Gamble
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                CircularProfileImageView(user: gamble.user, size: .small)
                
                Text(gamble.user?.userId ?? "")
                    .font(.footnote)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Text(gamble.timestamp.timestampString())
                    .font(.caption)
                    .foregroundStyle(Color(.systemGray3))
                
                Button {
                    
                } label: {
                    Image(systemName: "ellipsis")
                }
                
            }
            GambleCardView(gamble: gamble)
            
            ContentActionButtonsView(gamble: gamble)
                .foregroundColor(.secondary)
                .padding(.vertical, 8)
        }
        .padding(.horizontal)
        
        Divider()
    }
}

#Preview {
    GambleCellView(gamble: DeveloperPreview.shared.gamble)
}
