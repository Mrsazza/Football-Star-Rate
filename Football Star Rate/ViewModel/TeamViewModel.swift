//
//  TeamViewModel.swift
//  Football Star Rate
//
//  Created by Sazza on 6/1/22.
//

import Foundation
import SwiftUI


class TeamVM: ObservableObject{
    @Published var favoriteTeam : [TeamData]
    let saveKey = "SavedData"
    init() {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode([TeamData].self, from: data) {
                favoriteTeam = decoded
                return
            }
        }

        favoriteTeam = []
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(favoriteTeam) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    func add(_ team: TeamData) {
        favoriteTeam.append(team)
        save()
    }
    
    func removeRows(at offsets: IndexSet) {
        favoriteTeam.remove(atOffsets: offsets)
        save()
    }
}
