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
    
    @Published var currentUser: FirebaseAuth.User?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        AuthenticationManager.shared.$userSession.sink { [weak self] user in
            self?.currentUser = user
        }.store(in: &cancellables)
    }
}
