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
    @Published var completedRoot = CompletedRoot()
    @Published var oddLoading = false
    @Published var loading = false
    @Published var againLoading = false
    @Published var teamLoading = false
    @Published var oddArr: [NewOdds] = []
    @Published var teamOddArr: [NewOdds] = []
    @Published var date = Date()
    @Published var teamUpcomingRoot = Root()
    @Published var teams: [TeamData] = []
    @Published var isPast = false
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
//                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
//                    print("Key '\(key)' not found:", context.debugDescription)
//                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
//                    print("Value '\(value)' not found:", context.debugDescription)
//                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
//                    print("Type '\(type)' mismatch:", context.debugDescription)
//                    print("codingPath:", context.codingPath)
                } catch {
//                    print("error: ", error)
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
                   // print(context)
                } catch let DecodingError.keyNotFound(key, context) {
//                    print("Key '\(key)' not found:", context.debugDescription)
//                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
//                    print("Value '\(value)' not found:", context.debugDescription)
//                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
//                    print("Type '\(type)' mismatch:", context.debugDescription)
//                    print("codingPath:", context.codingPath)
                } catch {
//                    print("error: ", error)
                }
                return
            }
//            let matchData = try! JSONDecoder().decode(Root.self, from: data!)
//            DispatchQueue.main.async {
//                completion(matchData)
//            }
        }.resume()
    }
    
    func loadCompletedMatchData(date:String,completion:@escaping (CompletedRoot) -> ()) {
        guard let url = URL(string: "https://spoyer.ru/api/en/get.php?login=\(login)&token=\(token)&task=enddata&sport=soccer&day=\(date)") else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data{
                do{
                    let matchData = try JSONDecoder().decode(CompletedRoot.self, from: data)
                    if matchData.games_end.count != 0{
                        DispatchQueue.main.async {
                            completion(matchData)
                        }
                    }
                   print(matchData)
                    
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
//                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
//                    print("Key '\(key)' not found:", context.debugDescription)
//                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
//                    print("Value '\(value)' not found:", context.debugDescription)
//                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
//                    print("Type '\(type)' mismatch:", context.debugDescription)
//                    print("codingPath:", context.codingPath)
                } catch {
//                    print("error: ", error)
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
        self.root.games_pre = []
        ApiManager().loadPreMatchData(date: date){ (roots) in
            self.root = roots
            self.againLoading = false
      //      print(roots)
        }
    }
    
    // function for again fetching all data when date changes
    func fetchCompletedSource(date:String){
        self.root = Root()
       // self.oddRoot = OddRoot()
        self.oddArr = []
         self.againLoading = true
        self.root.games_pre = []
        ApiManager().loadCompletedMatchData(date: date){ (roots) in
            self.completedRoot = roots
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
    
    // function for fetching odds for the game
    func fetchPastOdd(gamesEnd: [GamesEnd]){
        //self.oddLoading = true
        for i in 0..<gamesEnd.count{
            ApiManager().loadOdds(gameId:gamesEnd[i].game_id){(odds) in
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
    
    
    func getTeam(){
        teams = []
        var game = self.root.games_pre
        var gamePast = self.completedRoot.games_end
        for i in (isPast ? (0..<completedRoot.games_end.count) : (0..<root.games_pre.count)){
            
            if (self.oddArr.contains(where: {$0.gameId == (isPast ? gamePast[i].game_id : game[i].game_id)})){
            var trialTeamData = TeamData()
                         
            trialTeamData.id = isPast ? gamePast[i].home.id : game[i].home.id
            trialTeamData.name = isPast ? gamePast[i].home.name : game[i].home.name
            trialTeamData.cc = isPast ? gamePast[i].home.cc : game[i].home.cc
            trialTeamData.image_id = isPast ? gamePast[i].home.image_id : game[i].home.image_id
            trialTeamData.chance = self.mainChance(homeOd: self.oddArr[self.oddArr.firstIndex(where: {$0.gameId == (isPast ? gamePast[i].game_id : game[i].game_id)})!].homeOd, drawOd:  self.oddArr[self.oddArr.firstIndex(where: {$0.gameId == (isPast ? gamePast[i].game_id : game[i].game_id)})!].drawOd, awayOd:  self.oddArr[self.oddArr.firstIndex(where: {$0.gameId == (isPast ? gamePast[i].game_id : game[i].game_id)})!].awayOd, selected: 1)

            
            teams.append(trialTeamData)
                trialTeamData.id = isPast ? gamePast[i].away.id : game[i].away.id
                trialTeamData.name = isPast ? gamePast[i].away.name : game[i].away.name
                trialTeamData.cc = isPast ? gamePast[i].away.cc : game[i].away.cc
                trialTeamData.image_id = isPast ? gamePast[i].away.image_id : game[i].away.image_id
                trialTeamData.chance = self.mainChance(homeOd: self.oddArr[self.oddArr.firstIndex(where: {$0.gameId == (isPast ? gamePast[i].game_id : game[i].game_id)})!].homeOd, drawOd:  self.oddArr[self.oddArr.firstIndex(where: {$0.gameId == (isPast ? gamePast[i].game_id : game[i].game_id)})!].drawOd, awayOd:  self.oddArr[self.oddArr.firstIndex(where: {$0.gameId == (isPast ? gamePast[i].game_id : game[i].game_id)})!].awayOd, selected: 3)
            
            teams.append(trialTeamData)
           // print("ddop: \(teams.count)")
        }
            // Sorts the array of teams by the biggest chances
           teams = teams.sorted(by: { $0.chance > $1.chance})
        }
    }
    
     func mainChance(homeOd:String, drawOd:String, awayOd:String, selected:Int) -> Int{
         let home = Float(homeOd)! - 1
         let draw = Float(drawOd)! - 1
         let away = Float(awayOd)! - 1
        
        let totalOd = home + draw + away
        let homeChance = 100 - ((home / totalOd) * 100)
        let drawChance = 100 - ((draw / totalOd) * 100)
        let awayChance = 100 - ((away / totalOd) * 100)
       // let totalChance = homeChance + drawChance + awayChance
        
        if selected == 1 {
            return Int(homeChance)
           // return Int((homeChance / totalChance) * 100)
        } else if selected == 2{
            return Int(drawChance)
            //return Int((drawChance / totalChance) * 100)
        } else{
            return Int(awayChance)
            //return Int((awayChance / totalChance) * 100)
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
