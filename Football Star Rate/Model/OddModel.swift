//
//  OddModel.swift
//  Football Star Rate
//
//  Created by Sazza on 29/12/21.
//

import Foundation


struct Prematch: Codable, Identifiable{
    let id = UUID().uuidString
    
    var home_od:String? = ""
    var draw_od:String? = ""
    var away_od:String? = ""
    var ss:String? = ""
    var add_time:String? = ""
    var handicap:String? = ""
    var over_od:String? = ""
    var under_od:String? = ""
}


struct Kickoff:Codable, Identifiable{
    let id = UUID().uuidString
    
    var home_od:String? = ""
    var draw_od:String? = ""
    var away_od:String? = ""
    var ss:String? = ""
    var add_time:String? = ""
    var handicap:String? = ""
    var over_od:String? = ""
    var under_od:String? = ""
}


struct Live:Codable,Identifiable{
    let id = UUID().uuidString
    
    var home_od:String? = ""
    var draw_od:String? = ""
    var away_od:String? = ""
    var ss:String? = ""
    var add_time:String? = ""
    var handicap:String? = ""
    var over_od:String? = ""
    var under_od:String? = ""
}


struct Bet3657:Codable,Identifiable{
    let id = UUID().uuidString
    
    var prematch: [Prematch]? = []
//    var kickoff: [Kickoff] = []
//    var live: [Live] = []
}


struct Odds:Codable, Identifiable{
    let id = UUID().uuidString
    var Bet365:Bet3657? = Bet3657()
}


struct OddRoot:Codable, Identifiable{
    let id = UUID().uuidString
    var time_request:Double = 0.0
    var capacity_requests:String = ""
    var remain_requests:String = ""
    var last_time_your_key:String = ""
    var game_id:String = ""
    var odds:Odds = Odds()
}

