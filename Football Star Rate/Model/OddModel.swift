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

//public class Bet365
//{
//public List<Prematch> prematch { get; set; }
//public List<Kickoff> kickoff { get; set; }
//public List<Live> live { get; set; }
//}

struct Bet3657:Codable,Identifiable{
    let id = UUID().uuidString
    
    var prematch: [Prematch]? = []
//    var kickoff: [Kickoff] = []
//    var live: [Live] = []
}

//public class Odds
//{
//public Bet365 Bet365 { get; set; }
//public _10Bet _10Bet { get; set; }
//public Ladbrokes Ladbrokes { get; set; }
//public WilliamHill WilliamHill { get; set; }
//public PlanetWin365 PlanetWin365 { get; set; }
//public _188Bet _188Bet { get; set; }
//public UniBet UniBet { get; set; }
//public BWin BWin { get; set; }
//public BetFair BetFair { get; set; }
//public CloudBet CloudBet { get; set; }
//public Betsson Betsson { get; set; }
//public SBOBET SBOBET { get; set; }
//public _888Sport _888Sport { get; set; }
//public BetAtHome BetAtHome { get; set; }
//public Marathonbet Marathonbet { get; set; }
//public BetVictor BetVictor { get; set; }
//public _1XBet _1XBet { get; set; }
//public BetRegal BetRegal { get; set; }
//public CashPoint CashPoint { get; set; }
//}

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

