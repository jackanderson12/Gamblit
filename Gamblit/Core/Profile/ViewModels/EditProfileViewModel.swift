//
//  EditProfileViewModel.swift
//  Gamblit
//
//  Created by Jack Anderson on 4/26/24.
//

import Foundation
import PhotosUI
import SwiftUI

@MainActor
class EditProfileViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var selectedItem: PhotosPickerItem? {
        didSet {
            Task {
                await loadImage()
            }
        }
    }
    @Published var profileImage: Image?
    
    private var uiImage: UIImage?
    
    func updateUserData() async throws {
        try await updateProfileImage()
    }
    
    func setUsername(user: DBUser) async throws {
        guard let userId = user.userId else {
            throw URLError(.userAuthenticationRequired)
        }
        
        // Check if the username is already taken
        if try await UserManager.shared.isUsernameTaken(username) {
            throw URLError(.dataNotAllowed)
        }
        
        // Update the username in Firestore
        try await UserManager.shared.updateUsername(for: userId, newUsername: username)
    }
    
    private func loadImage() async {
        guard let item = selectedItem else { return }
        
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
    }
    
    private func updateProfileImage() async throws {
        guard let image = self.uiImage else { return }
        guard let imageUrl = try? await ImageUploadManager.uploadImage(image) else { return }
        guard let uid = await AuthenticationManager.shared.userSession?.uid else { return }
        
        try await UserManager.shared.updateUserProfileImage(userId: uid, withImageUrl: imageUrl)
    }
}
