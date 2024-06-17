//
//  TableTalkCellView.swift
//  Gamblit
//
//  Created by Jack Anderson on 3/7/24.
//

import SwiftUI

struct TableTalkCellView: View {
    
    let tableTalk: TableTalk
    
    private var user: DBUser? {
        return tableTalk.user
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                
                CircularProfileImageView(user: user, size: .small)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(user?.userId ?? "")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Text(tableTalk.timestamp.timestampString())
                            .font(.caption)
                            .foregroundStyle(Color(.systemGray))
                        Button {
                            
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundStyle(Color(.darkGray))
                        }
                    }
                    Text(tableTalk.content)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                }
            }
            Divider()
        }
        .padding()
    }
}

#Preview {
    TableTalkCellView(tableTalk: DeveloperPreview.shared.tableTalk)
}
