//
//  ApiManager.swift
//  Football Star Rate
//
//  Created by Sazza on 27/12/21.
//

import Foundation

class ApiManager: ObservableObject{
    @Published var oddRoot = OddRoot()
    @Published var root = Root()
    @Published var oddLoading = false
    @Published var loading = false
    @Published var againLoading = false
    @Published var teamLoading = false
    @Published var oddArr: [NewOdds] = []
    @Published var teamOddArr: [NewOdds] = []
    @Published var date = Date()
    @Published var teamUpcomingRoot = Root()
    var login = "ayna"
    var token = "12784-OhJLY5mb3BSOx0O"
   
    func apiDate(date: Date) -> String{
       // let date = Date(timeIntervalSince1970: Double(time) ?? 1641101400)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let day = dateFormatter.string(from: date)
        return "\(day)"
    }
    
    func loadTeamUpcoming(teamId:String,completion:@escaping (Root) -> ()) {
        guard let url = URL(string: "https://spoyer.ru/api/en/get.php?login=\(login)&token=\(token)&task=predatapage&sport=soccer&team=\(teamId)") else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data{
                do{
                    let teamData = try JSONDecoder().decode(Root.self, from: data)
                    if teamData.games_pre.count != 0{
                        DispatchQueue.main.async {
                            completion(teamData)
                        }
                    }
                  // print(teamData)
                    
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
                return
            }
        }.resume()
    
    }
    
    func loadPreMatchData(date:String,completion:@escaping (Root) -> ()) {
        guard let url = URL(string: "https://spoyer.ru/api/en/get.php?login=\(login)&token=\(token)&task=predata&sport=soccer&day=\(date)") else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data{
                do{
                    let matchData = try JSONDecoder().decode(Root.self, from: data)
                    if matchData.games_pre.count != 0{
                        DispatchQueue.main.async {
                            completion(matchData)
                        }
                    }
                  // print(teamData)
                    
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
                return
            }
//            let matchData = try! JSONDecoder().decode(Root.self, from: data!)
//            DispatchQueue.main.async {
//                completion(matchData)
//            }
        }.resume()
        
    }
    
    func loadOdds(gameId:String,completion:@escaping (OddRoot) -> ()) {
        guard let oddUrl = URL(string: "https://spoyer.ru/api/en/get.php?login=\(login)&token=\(token)&task=odds&game_id=\(gameId)") else {
            print("Invalid odd url...")
            return
        }
       // print(oddUrl)
        URLSession.shared.dataTask(with: oddUrl) { data, response, error in
            if let data = data{
                do{
                    let odds = try JSONDecoder().decode(OddRoot.self, from: data)
                    if odds.odds.Bet365 != nil{
                        DispatchQueue.main.async {
                            completion(odds)
                        }
                    }
                   // print(odds)
                    
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
//                    print("Type '\(type)' mismatch:", context.debugDescription)
//                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
                return
            }
        }.resume()
        
    }
    // fetch team data
    func fetchTeamUpcoming(teamId:String){
        self.teamUpcomingRoot = Root()
    //    self.teamOddArr = []
        self.teamLoading = true
        self.loadTeamUpcoming(teamId: teamId) { (roots) in
            self.teamUpcomingRoot = roots
            //print(roots)
            self.teamLoading = false
        }
    }
    // fetch data on openning
    func fetchSource(date:String){
         self.loading = true
        ApiManager().loadPreMatchData(date: date){ (roots) in
            self.root = roots
            self.loading = false
        }
    }
    
    // function for again fetching all data when date changes
    func fetchSourceAgain(date:String){
        self.root = Root()
       // self.oddRoot = OddRoot()
        self.oddArr = []
         self.againLoading = true
        ApiManager().loadPreMatchData(date: date){ (roots) in
            self.root = roots
            self.againLoading = false
      //      print(roots)
        }
    }
    
    // function for fetching odds for the game
    func fetchOdd(gamesPre: [GamesPre]){
        //self.oddLoading = true
        for i in 0..<gamesPre.count{
            ApiManager().loadOdds(gameId:gamesPre[i].game_id){(odds) in
               // self.oddRoot = odds
                self.oddArr.append(NewOdds(gameId: odds.game_id, homeOd: odds.odds.Bet365?.prematch?[0].home_od ?? "N/A", awayOd: odds.odds.Bet365?.prematch?[0].away_od ?? "N/A", drawOd: odds.odds.Bet365?.prematch?[0].draw_od ?? "N/A"))
    //            print("Home: \(odds.odds.Bet365?.prematch?[0].home_od ?? "N/A"), Away: \(odds.odds.Bet365?.prematch?[0].away_od ?? "N/A")")
         //       self.oddLoading = false
            }
        }
    }
    
    func fetchTeamOdd(gamesPre: [GamesPre]){
        self.oddLoading = true
        for i in 0..<gamesPre.count{
            ApiManager().loadOdds(gameId:gamesPre[i].game_id){(odds) in
               // self.oddRoot = odds
                self.teamOddArr.append(NewOdds(gameId: odds.game_id, homeOd: odds.odds.Bet365?.prematch?[0].home_od ?? "N/A", awayOd: odds.odds.Bet365?.prematch?[0].away_od ?? "N/A", drawOd: odds.odds.Bet365?.prematch?[0].draw_od ?? "N/A"))
                print("Home: \(odds.odds.Bet365?.prematch?[0].home_od ?? "N/A"), Away: \(odds.odds.Bet365?.prematch?[0].away_od ?? "N/A")")
                self.oddLoading = false
            }
        }
    }
//
//    func loadOdds(gamesPre: [GamesPre]) {
//       for i in 0..<gamesPre.count{
//          fetchOdd(gameId: gamesPre[i].game_id)
//       }
//      print(oddArr)
//   }
}
