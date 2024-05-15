//
//  Query+EXT.swift
//  Gamblit
//
//  Created by Jack Anderson on 3/17/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

extension Query {
    
    func getDocuments<T>(as type: T.Type) async throws -> [T] where T: Decodable {
        let snapshot = try await self.getDocuments()
        
        return try snapshot.documents.map({ document in
            try document.data(as: T.self)
        })
    }
    
    func getDocumentsWithSnapshot<T>(as type: T.Type) async throws -> (gambles: [T], lastDocument: DocumentSnapshot?) where T: Decodable {
        let snapshot = try await self.getDocuments()
        
        let gambles = try snapshot.documents.map({ document in
            try document.data(as: T.self)
        })
        
        return (gambles, snapshot.documents.last)
    }
    
    
    func getTableTalkDocumentsWithSnapshot<T>(as type: T.Type) async throws -> (tableTalks: [T], lastDocument: DocumentSnapshot?) where T: Decodable {
        let snapshot = try await self.getDocuments()
        
        let tableTalks = try snapshot.documents.map({ document in
            try document.data(as: T.self)
        })
        
        return (tableTalks, snapshot.documents.last)
    }
    
    func startOptionally(afterDocument lastDocument: DocumentSnapshot?) -> Query {
        guard let lastDocument else { return self }
        return self.start(afterDocument: lastDocument)
    }
    
    func aggregateCount() async throws -> Int {
        let snapshot = try await self.count.getAggregation(source: .server)
        return Int(truncating: snapshot.count)
    }
    
    func addSnapshotListener<T>(as type: T.Type) -> (AnyPublisher<[T], Error>, ListenerRegistration) where T: Decodable {
        let publisher = PassthroughSubject<[T], Error>()
        
        let listener = self.addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("No Documents")
                return
            }
            
            let array: [T] = documents.compactMap({ try? $0.data(as: T.self) })
            publisher.send(array)
            
        }
        return (publisher.eraseToAnyPublisher(), listener)
    }
    
}
