//
//  NewOdds.swift
//  Football Star Rate
//
//  Created by Sazza on 29/12/21.
//

import Foundation

struct NewOdds:Identifiable{
    var id = UUID().uuidString
    var gameId: String = ""
    var homeOd: String = ""
    var awayOd: String = ""
    var drawOd: String = ""
}
