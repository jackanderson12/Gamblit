//
//  ProfileGambleFilter.swift
//  Gamblit
//
//  Created by Jack Anderson on 4/1/24.
//

import Foundation

enum ProfileGambleFilter: Int, CaseIterable, Identifiable {
    case gambles
    case tabletalks
    
    var title: String {
        switch self {
        case .gambles: return "Gambles"
        case .tabletalks: return "TableTalks"
        }
    }
    
    var id: Int { return self.rawValue }
}
