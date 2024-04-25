//
//  CurrentUserProfileView.swift
//  Gamblit
//
//  Created by Jack Anderson on 4/15/24.
//

import SwiftUI
import FirebaseAuth

struct CurrentUserProfileView: View {
    
    @StateObject var viewModel = CurrentUserProfileViewModel()
    
    private var currentUser: DBUser? {
        var user: DBUser? = nil
        Task {
            user = try? await UserManager.shared.getUser(userId: viewModel.currentUser?.uid ?? "")
        }
        return user
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    UserProfileHeaderView(user: currentUser)
                    
                    Button {
                        
                    } label: {
                        Text("Edit Profile")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                            .frame(width: 352, height: 32)
                            .background(.white)
                            .clipShape(.buttonBorder)
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(.systemGray), lineWidth: 1)
                            }
                    }
                    
                    //User Content List View
                    UserContentListView()
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button {
                        try? AuthenticationManager.shared.signOut()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                    }

                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    CurrentUserProfileView()
}
