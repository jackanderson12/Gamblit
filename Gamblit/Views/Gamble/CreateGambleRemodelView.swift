//
//  CreateGambleRemodelView.swift
//  Gamblit
//
//  Created by Jack Anderson on 4/2/24.
//

import SwiftUI

struct CreateGambleRemodelView: View {
    
    @State private var title = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(alignment: .top) {
                    CircularProfileImageView()
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("username1")
                            .fontWeight(.semibold)
                        
                        TextField("Start a Gamble...", text: $title, axis: .vertical)
                    }
                    .font(.footnote)
                    
                    Spacer()
                    
                    if !title.isEmpty {
                        Button {
                            title = ""
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 12, height: 12)
                                .foregroundStyle(.gray)
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("New Gamble")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("cancel") {
                        dismiss()
                    }
                    .foregroundStyle(.black)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Post") {
                        
                    }
                    .opacity(title.isEmpty ? 0.5 : 1.0)
                    .disabled(title.isEmpty)
                    .foregroundStyle(.black)
                }
            }
        }
    }
}

#Preview {
    CreateGambleRemodelView()
}
