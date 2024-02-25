//
//  CreateGambleView.swift
//  Gamblit
//
//  Created by Jack Anderson on 2/25/24.
//

import SwiftUI

struct CreateGambleView: View {
    
    @State private var gambleTitle: String = ""
    @State private var gambleDescription: String = ""
    
    var body: some View {
        VStack {
            Form {
                Section("Title") {
                    TextField("Title", text: $gambleTitle)
                }
                Section("Description") {
                    TextField("Description", text: $gambleDescription)
                }
            }
            Button("Post") {
                Task {
                    try? await GambleManager.shared.uploadGamble(gamble: Gamble(id: String("\(UUID())"), title: gambleTitle, description: gambleDescription, likes: 1, dislikes: 0))
                }
            }
        }
    }
}

#Preview {
    CreateGambleView()
}
