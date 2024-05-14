//
//  GambleTableTalksProfileCell.swift
//  Gamblit
//
//  Created by Jack Anderson on 5/14/24.
//

import SwiftUI

struct GambleTableTalksProfileCell: View {
    let tableTalk: TableTalk
    
    var body: some View {
        VStack(alignment: .leading) {
            if let gamble = tableTalk.gamble {
                HStack(alignment: .top) {
                    VStack {
                        CircularProfileImageView(user: gamble.user, size: .small)
                        
                        Rectangle()
                            .frame(width: 2, height: 64)
                            .foregroundStyle(Color(.systemGray4))
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(gamble.user?.userId ?? "")
                                .fontWeight(.semibold)
                            
                            Text(gamble.title)
                        }
                        .font(.footnote)
                        
                        ContentActionButtonsView(gamble: gamble)
                    }
                    
                    Spacer()
                }
            }
            
            HStack(alignment: .top) {
                CircularProfileImageView(user: tableTalk.user, size: .small)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(tableTalk.user?.userId ?? "")
                        .fontWeight(.semibold)
                    
                    Text(tableTalk.content)
                }
                .font(.footnote)
            }
            
            Divider()
        }
    }
}

#Preview {
    GambleTableTalksProfileCell(tableTalk: DeveloperPreview.shared.tableTalk)
}
