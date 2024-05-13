//
//  PreviewProvider.swift
//  Gamblit
//
//  Created by Jack Anderson on 4/15/24.
//

import Foundation
import Firebase

class DeveloperPreview {
    static let shared = DeveloperPreview()
    
    let user = DBUser(userId: String("\(UUID())"), isAnonymous: false, photoUrl: "www.google.com/images", dateCreated: Date(), isPremium: true, sportsBooks: ["Draftkings", "Fanduel"])
    
    lazy var gamble = Gamble(
        userId: "123",
        game: Game(id: "123", commenceTime: "Tomorrow", homeTeam: "Washington Captials", awayTeam: "Boston Bruins", sportKey: "NHL", sportTitle: "Hockey", bookmakers: []),
        title: "The Capitals are going to win!",
        description: "The caps will win because OV is on the goal scoring record chase.",
        timestamp: Timestamp(),
        tableTalkCount: 9,
        likes: 100
    )
}
