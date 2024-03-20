//
//  GambleCardView.swift
//  Gamblit
//
//  Created by Jack Anderson on 12/12/23.
//

import SwiftUI
import Charts

struct GambleCardView: View {
    
    @StateObject var viewModel: GambleDetailViewModel
    @StateObject var profileViewModel: ProfileViewModel
    
    @Binding var gamble: Gamble
    
    @State private var newTableTalk: Bool = false
    @State private var tableTalkContent: String = ""
    
    @State private var userLikes: Bool = false
    @State private var userDislikes: Bool = false

    var body: some View {
        VStack {
            Text(gamble.title) //Placeholder for what to place here
                .font(.headline)

            //ChartView()
                //.frame(height: 100) // Adjust as needed

            Text(gamble.description)
                .font(.body)
                .lineLimit(1)
                .truncationMode(.tail)

            HStack {
                Button(action: {
                    Task {
                        userLikes.toggle()
                        
                        if userLikes && !userDislikes {
                            try? await viewModel.updateGambleLikeCount(gambleId: gamble.id, likes: gamble.likes + 1)
                        } else if userLikes && userDislikes {
                            userDislikes.toggle()
                            try? await viewModel.updateGambleLikeCount(gambleId: gamble.id, likes: gamble.likes + 2)
                        }
                    }
                }) {
                        Image(systemName: "arrow.up")
                }
                .tint(userLikes ? .green : .blue)
                
                Text("\(gamble.likes)")
                
                Button(action: {
                    Task {
                        userDislikes.toggle()
                        
                        if userDislikes && !userLikes {
                            try? await viewModel.updateGambleLikeCount(gambleId: gamble.id, likes: gamble.likes - 1)
                        } else if userDislikes && userLikes {
                            try? await viewModel.updateGambleLikeCount(gambleId: gamble.id, likes: gamble.likes - 2)
                        }
                    }
                }) {
                    Image(systemName: "arrow.down")
                }
                .tint(userDislikes ? .red : .blue)

                Button(action: {
                    newTableTalk.toggle()
                }) {
                    Image(systemName: "message")
                }
            }
        }
        .task {
            try? await profileViewModel.loadCurrentUser()
        }
        .sheet(isPresented: $newTableTalk) {
            VStack(alignment: .center) {
                TextField("Reply", text: $tableTalkContent)
                Button("Submit") {
                    Task {
                        try? await viewModel.uploadTableTalk(gambleId:gamble.id, userId:profileViewModel.user!.userId, content: tableTalkContent)
                        try? await viewModel.getTableTalkForGamble(gambleId: gamble.id)
                    }
                    newTableTalk.toggle()
                }
            }
            .padding(.all)
        }
        .padding()
        .cornerRadius(15)
        .shadow(radius: 10)
    }
}
