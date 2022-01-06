//
//  CompletedMatchModel.swift
//  Football Star Rate
//
//  Created by Sazza on 7/1/22.
//

import Foundation

//public class League
// {
// public string name { get; set; }
// public string cc { get; set; }
// public string id { get; set; }
// }

//struct League: Codable, Identifiable{
//    var name: String = ""
//    var cc: String? = ""
//    var id: String = ""
//}

// public class Home
// {
// public string name { get; set; }
// public string id { get; set; }
// public string image_id { get; set; }
// public string cc { get; set; }
// }

//struct Home: Codable, Identifiable{
//    var name: String = ""
//    var id: String = ""
//    var image_id: String = ""
//    var cc: String? = ""
//}

// public class Away
// {
// public string name { get; set; }
// public string id { get; set; }
// public string image_id { get; set; }
// public string cc { get; set; }
// }

//struct Away: Codable, Identifiable{
//    var name: String = ""
//    var id: String = ""
//    var image_id: String = ""
//    var cc: String? = ""
//}

//public class GamesEnd
//{
//public string game_id { get; set; }
//public string time { get; set; }
//public string time_status { get; set; }
//public League league { get; set; }
//public Home home { get; set; }
//public Away away { get; set; }
//public string score { get; set; }
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

// public class Root
// {
// public double time_request { get; set; }
// public string capacity_requests { get; set; }
// public string remain_requests { get; set; }
// public string last_time_your_key { get; set; }
// public string date_games { get; set; }
// public List<GamesPre> games_pre { get; set; }
// }

struct CompletedRoot: Codable, Identifiable{
    let id = UUID()
    var time_request: Double = 0.0
    var capacity_requests: String = ""
    var remain_requests: String = ""
    var last_time_your_key: String = ""
    var date_games: String = ""
    var games_end: [GamesEnd] = []
}
