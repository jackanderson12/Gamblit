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
        VStack {
            HStack(alignment: .top, spacing: 12) {
                
                CircularProfileImageView(user: gamble.user, size: .small)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(gamble.userId)
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Text(gamble.timestamp.timestampString())
                            .font(.caption)
                            .foregroundStyle(Color(.systemGray))
                        Button {
                            
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundStyle(Color(.darkGray))
                        }
                    }
                    Text(gamble.title)
                    Text(gamble.title)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                    
                    HStack(spacing: 16) {
                        Button {
                            
                        } label: {
                            Image(systemName: "heart")
                        }

                        Button {
                            
                        } label: {
                            Image(systemName: "bubble.right")
                        }
                        Button {
                            
                        } label: {
                            Image(systemName: "arrow.rectanglepath")
                        }

                        Button {
                            
                        } label: {
                            Image(systemName: "paperplane")
                        }
                    }
                    .foregroundColor(.black)
                    .padding(.vertical, 8)
                }
            }
            Divider()
        }
        .padding()
    }
}

#Preview {
    GambleCellView(gamble: DeveloperPreview.shared.gamble)
}
