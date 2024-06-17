//
//  GambleViewModel.swift
//  Gamblit
//
//  Created by Jack Anderson on 1/18/24.
//

import Firebase
import Combine

@MainActor
class GambleViewModel: ObservableObject {
    
    @Published var game: Game? = nil
    @Published var bookmakers: [Bookmakers]? = nil
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var likes: Int = 0
    
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
    
    func uploadGamble() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let gamble = Gamble(userId: uid, game: game ?? Game(id: "", commenceTime: "", homeTeam: "", awayTeam: "", sportKey: "", sportTitle: "", bookmakers: []), bookmakers: bookmakers ?? [], title: title, description: description, timestamp: Timestamp(), tableTalkCount: 0, likes: likes)
        try? await GambleManagerRemodel.uploadGamble(gamble)
    }
}
