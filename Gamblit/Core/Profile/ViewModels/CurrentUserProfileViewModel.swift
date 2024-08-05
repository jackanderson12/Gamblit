//
//  CurrentUserProfileViewModel.swift
//  Gamblit
//
//  Created by Jack Anderson on 4/15/24.
//

import Foundation
import Combine
import FirebaseAuth


class CurrentUserProfileViewModel: ObservableObject {
    
    @Published var currentUser: DBUser?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        UserManager.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
        }.store(in: &cancellables)
    }
    
    @MainActor
    func refreshUser() async throws {
        try await UserManager.shared.fetchCurrentUser()
    }
}
