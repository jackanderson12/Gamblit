//
//  PreviewProvider.swift
//  Gamblit
//
//  Created by Jack Anderson on 4/15/24.
//

import Foundation

class DeveloperPreview {
    static let shared = DeveloperPreview()
    
    let user = DBUser(userId: String("\(UUID())"), isAnonymous: false, photoUrl: "www.google.com/images", dateCreated: Date(), isPremium: true, sportsBooks: ["Draftkings", "Fanduel"])
}