//
//  PreviewProvider.swift
//  Gamblit
//
//  Created by Jack Anderson on 4/15/24.
//

import Foundation
import Firebase
import SwiftUI

class DeveloperPreview {
    static let shared = DeveloperPreview()
    
    let user = DBUser(
        userId: String("\(UUID())"),
        isAnonymous: false,
        photoUrl: "www.google.com/images",
        dateCreated: Date(),
        isPremium: true,
        sportsBooks: ["Draftkings", "Fanduel"]
    )
    
    lazy var outcomes: [Outcome] = [
        Outcome(name: "Over", price: 1.89, point: 36.5),
        Outcome(name: "Under", price: 1.93, point: 36.5)
    ]
    
    lazy var markets: [Markets] = [
        Markets(
            key: "totals",
            lastUpdate: "2024-01-02T16:08:04Z",
            outcomes: outcomes
        )
    ]
    
    lazy var bookmakers: [Bookmakers] = [
        Bookmakers(
            key: "fanduel",
            title: "FanDuel",
            lastUpdate: "2024-01-02T16:08:04Z",
            markets: markets
        )
    ]
    
    lazy var bookmakerTuple: [(String, Bool)] = [
        ("Draftkings", true)
    ]
    
    lazy var game: Game = Game(
        id: "f1db1ea65e63375c8f6f9766dac5d4f7",
        commenceTime: "2024-01-06T21:31:00Z",
        homeTeam: "Baltimore Ravens",
        awayTeam: "Pittsburgh Steelers",
        sportKey: "americanfootball_nfl",
        sportTitle: "NFL",
        bookmakers: bookmakers
    )
    
    lazy var gamble: Gamble = Gamble(
        userId: "123",
        game: game,
        bookmakers: bookmakers, 
        title: "The Capitals are going to win!",
        description: "The caps will win because OV is on the goal scoring record chase.",
        timestamp: Timestamp(),
        tableTalkCount: 9,
        likes: 100
    )
    
    lazy var tableTalk: TableTalk = TableTalk(
        gambleId: "123",
        gambleOwnerUserId: "1234",
        userId: "123",
        content: "",
        timestamp: Timestamp()
    )
    
    lazy var bindingBooks: Binding<[Bookmakers]?> =
        Binding(
            get: { self.bookmakers },
            set: { newValue in
                self.bookmakers = newValue ?? []
            }
        )
    lazy var bindingBookmakers: Binding<[(String, Bool)]> = Binding(
        get: { self.bookmakerTuple},
        set: { newValue in
            self.bookmakerTuple = newValue
        }
    )
}

