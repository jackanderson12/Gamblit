//
//  DBUser.swift
//  Gamblit
//
//  Created by Jack Anderson on 12/15/23.
//

import Foundation

struct DBUser: Codable, Identifiable, Hashable {
    let userId: String
    let isAnonymous: Bool?
    let dateCreated: Date?
    let profileImageUrl: String?
    let isPremium: Bool?
    let sportsBooks: [String]?
    
    // Computed property to conform to Identifiable
    var id: String {
        return userId
    }
    
    init(auth: AuthDataResultModel) {
        self.userId = auth.uid
        self.isAnonymous = auth.isAnonymous
        self.profileImageUrl = auth.profileImageUrl
        self.dateCreated = Date()
        self.isPremium = false
        self.sportsBooks = nil
    }
    
    init(userId: String,
         isAnonymous: Bool? = nil,
         photoUrl: String? = nil,
         dateCreated: Date? = nil,
         isPremium: Bool? = nil,
         sportsBooks: [String]? = nil
    ) {
        self.userId = userId
        self.isAnonymous = isAnonymous
        self.profileImageUrl = photoUrl
        self.dateCreated = Date()
        self.isPremium = isPremium
        self.sportsBooks = sportsBooks
    }
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case isAnonymous = "is_anonymous"
        case photoUrl = "photo_url"
        case dateCreated = "date_created"
        case isPremium = "is_premium"
        case sportsBooks = "sports_books"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.isAnonymous = try container.decodeIfPresent(Bool.self, forKey: .isAnonymous)
        self.dateCreated = try container.decodeIfPresent(Date.self, forKey: .dateCreated)
        self.profileImageUrl = try container.decodeIfPresent(String.self, forKey: .photoUrl)
        self.isPremium = try container.decodeIfPresent(Bool.self, forKey: .isPremium)
        self.sportsBooks = try container.decodeIfPresent([String].self, forKey: .sportsBooks)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.userId, forKey: .userId)
        try container.encodeIfPresent(self.isAnonymous, forKey: .isAnonymous)
        try container.encodeIfPresent(self.profileImageUrl, forKey: .photoUrl)
        try container.encodeIfPresent(self.dateCreated, forKey: .dateCreated)
        try container.encodeIfPresent(self.isPremium, forKey: .isPremium)
        try container.encodeIfPresent(self.sportsBooks, forKey: .sportsBooks)
    }
    
}
