//
//  GambleDetailView.swift
//  Gamblit
//
//  Created by Jack Anderson on 3/7/24.
//

import SwiftUI

struct GambleDetailView: View {
    let gamble: Gamble
    
    var body: some View {
        ScrollView {
            VStack {
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
                
                VStack(alignment: .leading, spacing: 12) {
                    Text(gamble.title)
                        .font(.subheadline)
                    
                    ContentActionButtonsView(gamble: gamble)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Divider()
                    .padding(.vertical)
                
                LazyVStack {
                    ForEach(0...10, id: \.self) { tableTalk in
                        Text("Table Talks go here...")
                    }
                }
            }
        }
        .padding()
        .navigationTitle("Gamble")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    GambleDetailView(gamble: DeveloperPreview.shared.gamble)
}

//struct ShowTableTalkView: View {
//    let tableTalk: TableTalk
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            HStack {
//                Text(tableTalk.userId)
//                    .font(.subheadline)
//                    .fontWeight(.bold)
//            }
//            
//            Text(tableTalk.content)
//                .font(.body)
//            
//            if !tableTalk.replies.isEmpty {
//                VStack(alignment: .leading, spacing: 8) {
//                    ForEach(tableTalk.replies, id: \.id) { reply in
//                        ShowTableTalkView(tableTalk: reply)
//                            .padding(.leading)
//                    }
//                }
//            }
//        }
//        .padding()
//        .background(Color(.systemBackground))
//        .cornerRadius(8)
//        .shadow(radius: 2)
//    }
//}
