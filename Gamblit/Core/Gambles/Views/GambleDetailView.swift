//
//  GambleDetailView.swift
//  Gamblit
//
//  Created by Jack Anderson on 3/7/24.
//

import SwiftUI

struct GambleDetailView: View {
    let gamble: Gamble
    @StateObject var viewModel: GambleDetailViewModel
    
    init(gamble: Gamble, viewModel: GambleDetailViewModel) {
        self.gamble = gamble
        self._viewModel = StateObject(wrappedValue: GambleDetailViewModel(gamble: gamble))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    CircularProfileImageView(user: gamble.user, size: .small)
                    
                    Text(gamble.user?.username ?? "")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Text(gamble.timestamp.timestampString())
                        .font(.caption)
                        .foregroundStyle(Color(.systemGray3))
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "ellipsis")
                            .foregroundStyle(Color(.systemGray3))
                    }

                }
                
                VStack(alignment: .leading, spacing: 12) {
                    GambleCardView(gamble: gamble)
                    
                    ContentActionButtonsView(gamble: gamble)
                }
                
                Divider()
                    .padding(.vertical)
                
                LazyVStack {
                    ForEach(viewModel.tableTalks, id: \.self) { tableTalk in
                        TableTalkCellView(tableTalk: tableTalk)
                    }
                }
            }
        }
        .navigationTitle("Gamble")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    GambleDetailView(gamble: DeveloperPreview.shared.gamble, viewModel: GambleDetailViewModel(gamble: DeveloperPreview.shared.gamble))
}
