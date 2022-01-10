//
//  CompletedMatchModel.swift
//  Football Star Rate
//
//  Created by Sazza on 7/1/22.
//

import Foundation


//struct League: Codable, Identifiable{
//    var name: String = ""
//    var cc: String? = ""
//    var id: String = ""
//}


//struct Home: Codable, Identifiable{
//    var name: String = ""
//    var id: String = ""
//    var image_id: String = ""
//    var cc: String? = ""
//}

//struct Away: Codable, Identifiable{
//    var name: String = ""
//    var id: String = ""
//    var image_id: String = ""
//    var cc: String? = ""
//}

struct GamesEnd: Codable, Identifiable{
    let id = UUID()
    var game_id: String = ""
    var time: String = ""
    var time_status : String = ""
    var league: League = League()
    var home: Home = Home()
    var away: Away = Away()
    var score: String = ""
}


struct CompletedRoot: Codable, Identifiable{
    let id = UUID()
    var time_request: Double = 0.0
    var capacity_requests: String = ""
    var remain_requests: String = ""
    var last_time_your_key: String = ""
    var date_games: String = ""
    var games_end: [GamesEnd] = []
}
