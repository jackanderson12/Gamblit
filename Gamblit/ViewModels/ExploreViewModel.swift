//
//  ExploreViewModel.swift
//  Gamblit
//
//  Created by Jack Anderson on 4/16/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class ExploreViewModel: ObservableObject {
    
    @Published var users = [DBUser]()
    
    init() {
        Task {
            try await fetchUsers()
        }
    }
    
    private func fetchUsers() async throws {
        self.users = try await UserManager.shared.getAllUsers()
    }
}
