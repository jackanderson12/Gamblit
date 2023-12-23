//
//  SportsMenuViewModel.swift
//  Gamblit
//
//  Created by Jack Anderson on 12/22/23.
//

import Foundation

@MainActor
final class SportMenuViewModel: ObservableObject {
    @Published var sports = ["Football", "Basketball", "Baseball", "Soccer", "Hockey", "MMA"]
}
