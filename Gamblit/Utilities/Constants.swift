//
//  Constants.swift
//  Gamblit
//
//  Created by Jack Anderson on 5/9/24.
//

import Firebase

struct FirestoreConstants {
    private static let Root = Firestore.firestore()
    
    static let userCollection = Root.collection("users")
    static let gambleCollection = Root.collection("gambles")
    
    static let followersCollection = Root.collection("followers")
    static let followingCollection = Root.collection("following")
    
    static let tableTalkCollection = Root.collection("tableTalks")
    static let activityCollection = Root.collection("activity")
}

