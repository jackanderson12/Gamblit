//
//  EditProfileView.swift
//  Gamblit
//
//  Created by Jack Anderson on 4/2/24.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    
    let user: DBUser
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = EditProfileViewModel()
    
    @State private var link = ""
    @State private var isPrivateProfile = false
    
    let sportsBooks: [String] = ["Draft Kings", "Fanduel", "Bet MGM", "Caesars"]
    
    private func sportsBookIsSelected(sportsBook: String) -> Bool {
        user.sportsBooks?.contains(sportsBook) == true
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea(edges: [.bottom, .horizontal])
                
                VStack {
                    // Name and Profile Image
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Name")
                                .fontWeight(.semibold)
                                .foregroundStyle(.black)
                            
                            TextField("\(user.username ?? user.userId!)", text: $viewModel.username, axis: .vertical)
                                .foregroundStyle(.black)
                                .onSubmit {
                                    if viewModel.username != "" {
                                        Task {
                                            try await viewModel.setUsername(user: user)
                                        }
                                    }
                                }
                        }
                        
                        Spacer()
                        
                        PhotosPicker(selection: $viewModel.selectedItem) {
                            if let image = viewModel.profileImage {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width:40, height: 40)
                                    .clipShape(.circle)
                            } else {
                                CircularProfileImageView(user: user, size: .small)
                            }
                        }
                    }
                    
                    Divider()
                    
                    //Bio Field
                    VStack(alignment: .leading) {
                        Text("Bio")
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                        
                        TextField("Enter your bio...", text: $viewModel.bio, axis: .vertical)
                            .foregroundStyle(.black)
                            .onSubmit {
                                if viewModel.bio != "" {
                                    Task {
                                        try await viewModel.setUsername(user: user)
                                    }
                                }
                            }
                    }
                    
                    Divider()
                    
                    //Sportsbooks Section
                    VStack{
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(sportsBooks, id: \.self) { book in
                                    Button(book) {
                                        if sportsBookIsSelected(sportsBook: book) {
                                            Task {
                                                try await viewModel.removeUserSportsBooks(user: user, sportsBooks: book)
                                            }
                                        } else {
                                            Task {
                                                try await viewModel.addUserSportsBooks(user: user, sportsBooks: book)
                                            }
                                        }
                                    }
                                    .font(.subheadline)
                                    .buttonStyle(.borderedProminent)
                                    .tint(sportsBookIsSelected(sportsBook: book) ? .green : .red)
                                }
                            }
                        }
                        Text("User Sports Books: \((user.sportsBooks  ?? []).joined(separator: ", "))")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text("Link")
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                        
                        TextField("Add Link...", text: $link, axis: .vertical)
                            .foregroundStyle(.black)
                    }
                    
                    Divider()
                    
                    Toggle("Private Profile", isOn: $isPrivateProfile)
                }
                .font(.footnote)
                .padding()
                .background(.secondary)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(uiColor: .systemGray), lineWidth: 1)
                }
                .padding()
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        Task {
                            try await viewModel.updateUserData()
                            dismiss()
                        }
                    }
                    .foregroundStyle(.primary)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundStyle(.primary)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        EditProfileView(user: DeveloperPreview.shared.user)
    }
}
