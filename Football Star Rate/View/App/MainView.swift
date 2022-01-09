//
//  MainView.swift
//  Football Star Rate
//
//  Created by Sazza on 25/12/21.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var api:ApiManager
    @State private var isSelectedTournament : Bool = false
    @State var leagueArr = [String]()
    @State var selectedLeague = ""
    @State var date = Date()
    @State var isPast = false
   
    private func matchDate(date: Date) -> String{
       // let date = Date(timeIntervalSince1970: Double(time) ?? 1641101400)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let day = dateFormatter.string(from: date)
        return "\(day)"
    }
    
    private func selectDay(date:Date){
        if matchDate(date: date) == matchDate(date: Date()){
            api.fetchSourceAgain(date: api.apiDate(date: date))
            api.isPast = false
        }
        else if matchDate(date: date) > matchDate(date: Date()){
            api.fetchSourceAgain(date: api.apiDate(date: date))
            api.isPast = false
            
        } else if matchDate(date: date) < matchDate(date: Date()){
            api.fetchCompletedSource(date: api.apiDate(date: date))
            api.isPast = true
        }
    }
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.accentColor
                VStack(spacing: 0){
                    
                    // Top Bar View
                    TopBar(tabName: "Upcoming Matches")
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color("Blue"))
                            .frame(width: nil, height: 55)
                        HStack {
                            Spacer()
                            
                            // Top Left (The tournament selection view)
                            VStack {
                                ZStack {
                                    HStack{
                                        Text("Tournament")
                                            .foregroundColor(isSelectedTournament ? Color("Green") : .white)
                                        Image(isSelectedTournament ? "arrowDown" : "arrowRight")
                                    }
                                    if isSelectedTournament{
                                    Rectangle()
                                        .foregroundColor(Color("Green"))
                                            .frame( width: 150, height: 5, alignment: .leading)
                                            .padding(.top,40)
                                    }
                                }
                            }
                            .onTapGesture {
                                isSelectedTournament.toggle()
                            }
                            Spacer()
                            
                            // Top Right(Date selection)
                            HStack{
                                Image("arrowLeft")
                                    .onTapGesture {
                                        api.date = Calendar.current.date(byAdding: .day, value: -1, to: api.date)!
                                        selectDay(date: api.date)
                                    }
                                Text(matchDate(date: api.date))
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                Image("arrowRight")
                                    .onTapGesture {
                                        api.date = Calendar.current.date(byAdding: .day, value: 1, to: api.date)!
                                        selectDay(date: api.date)
                                    }
                            }
//                            .onTapGesture {
//                               // print(api.root.games_pre.count)
//                            }
                            Spacer()
                        }
                    }
                    
                    // All the main components in the middle center
                    ZStack(alignment:.leading){
                        ScrollView {
                            if api.isPast {
                                ForEach(api.completedRoot.games_end, id:\.id){(match) in
                                    
                                    // To filter the team according to selected league
                                    if selectedLeague == match.league.name{
                                        if (api.oddArr.contains(where: {$0.gameId == match.game_id})){
                                            NavigationLink(destination: MatchDetailView(api:api,
                                                                                        gameEnd: match,
                                                                                        homeOd: api.oddArr[api.oddArr.firstIndex(where: {$0.gameId == match.game_id})!].homeOd,
                                                                                        awayOd: api.oddArr[api.oddArr.firstIndex(where: {$0.gameId == match.game_id})!].awayOd,drawOd: api.oddArr[api.oddArr.firstIndex(where: {$0.gameId == match.game_id})!].drawOd)){
                                                MainViewList(homeTeam: match.home.name , awayTeam: match.away.name, homeOd: api.oddArr[api.oddArr.firstIndex(where: {$0.gameId == match.game_id})!].homeOd, awayOd: api.oddArr[api.oddArr.firstIndex(where: {$0.gameId == match.game_id})!].awayOd)
                                           
                                        }
                                            
                                        }
    //                                    else{
    //                                        NavigationLink(destination: MatchDetailView(game: match)){
    //                                            MainViewList(homeTeam: match.home.name, awayTeam: match.away.name)
    //                                        }
    //                                    }
                                    }
                             
                                    // To show all the team and leagues
                                    else if selectedLeague == ""{
                                        if (api.oddArr.contains(where: {$0.gameId == match.game_id})){
                                            NavigationLink(destination: MatchDetailView(api:api,gameEnd: match,homeOd: api.oddArr[api.oddArr.firstIndex(where: {$0.gameId == match.game_id})!].homeOd, awayOd: api.oddArr[api.oddArr.firstIndex(where: {$0.gameId == match.game_id})!].awayOd,drawOd: api.oddArr[api.oddArr.firstIndex(where: {$0.gameId == match.game_id})!].drawOd )){
                                            
                                                MainViewList(homeTeam: match.home.name , awayTeam: match.away.name, homeOd: api.oddArr[api.oddArr.firstIndex(where: {$0.gameId == match.game_id})!].homeOd, awayOd: api.oddArr[api.oddArr.firstIndex(where: {$0.gameId == match.game_id})!].awayOd)
                                            }
                                        }
    //                                    else{
    //                                        NavigationLink(destination: MatchDetailView(game: match)){
    //                                            MainViewList(homeTeam: match.home.name, awayTeam: match.away.name)
    //                                        }
    //                                    }
                                    }
                                }
                            }
                            else {
                            ForEach(api.root.games_pre, id:\.id){(match) in
                                
                                // To filter the team according to selected league
                                if selectedLeague == match.league.name{
                                    if (api.oddArr.contains(where: {$0.gameId == match.game_id})){
                                        NavigationLink(destination: MatchDetailView(api:api,game: match,homeOd: api.oddArr[api.oddArr.firstIndex(where: {$0.gameId == match.game_id})!].homeOd, awayOd: api.oddArr[api.oddArr.firstIndex(where: {$0.gameId == match.game_id})!].awayOd,drawOd: api.oddArr[api.oddArr.firstIndex(where: {$0.gameId == match.game_id})!].drawOd)){
                                            MainViewList(homeTeam: match.home.name , awayTeam: match.away.name, homeOd: api.oddArr[api.oddArr.firstIndex(where: {$0.gameId == match.game_id})!].homeOd, awayOd: api.oddArr[api.oddArr.firstIndex(where: {$0.gameId == match.game_id})!].awayOd)
                                       
                                    }
                                        
                                    }
//                                    else{
//                                        NavigationLink(destination: MatchDetailView(game: match)){
//                                            MainViewList(homeTeam: match.home.name, awayTeam: match.away.name)
//                                        }
//                                    }
                                }
                         
                                // To show all the team and leagues
                                else if selectedLeague == ""{
                                    if (api.oddArr.contains(where: {$0.gameId == match.game_id})){
                                        NavigationLink(destination: MatchDetailView(api:api,game: match,homeOd: api.oddArr[api.oddArr.firstIndex(where: {$0.gameId == match.game_id})!].homeOd, awayOd: api.oddArr[api.oddArr.firstIndex(where: {$0.gameId == match.game_id})!].awayOd,drawOd: api.oddArr[api.oddArr.firstIndex(where: {$0.gameId == match.game_id})!].drawOd )){
                                        
                                            MainViewList(homeTeam: match.home.name , awayTeam: match.away.name, homeOd: api.oddArr[api.oddArr.firstIndex(where: {$0.gameId == match.game_id})!].homeOd, awayOd: api.oddArr[api.oddArr.firstIndex(where: {$0.gameId == match.game_id})!].awayOd)
                                        }
                                    }
//                                    else{
//                                        NavigationLink(destination: MatchDetailView(game: match)){
//                                            MainViewList(homeTeam: match.home.name, awayTeam: match.away.name)
//                                        }
//                                    }
                                }
                            }
                                
                            }
                        }//:SCROLL VIEW
                        
                        // Shows the league view if tapped
                        if isSelectedTournament {
                            TournamentList(leagueArray: leagueArr, selectedLeague: $selectedLeague)
                        }
                    }
                    Spacer()
                }
            }
    
            .navigationBarHidden(true)
        }
//        .onAppear{
//
//        }
        .onChange(of: api.oddArr.count){_ in
           // print(api.oddArr)
            if api.isPast {
                addPastLeague(gamesEnd: api.completedRoot.games_end)
            } else {
            addLeague(gamesPre: api.root.games_pre)
            }
        }
    }
    
    // gets the leagues and filters them
    private func addLeague(gamesPre: [GamesPre]){
        for match in  0..<gamesPre.count{
            // checks if the game has any ods from api
            if (api.oddArr.contains(where: {$0.gameId == gamesPre[match].game_id})){
                // checks if the array contains the league
                if leagueArr.contains(api.root.games_pre[match].league.name){
                    //
                } else {
                    // appends the unique league
                    leagueArr.append(api.root.games_pre[match].league.name)
                }
            }
        }
       // print(leagueArr)
    }
    // gets the leagues and filters them
    private func addPastLeague(gamesEnd: [GamesEnd]){
        for match in  0..<gamesEnd.count{
            // checks if the game has any ods from api
            if (api.oddArr.contains(where: {$0.gameId == gamesEnd[match].game_id})){
                // checks if the array contains the league
                if leagueArr.contains(api.completedRoot.games_end[match].league.name){
                    //
                } else {
                    // appends the unique league
                    leagueArr.append(api.completedRoot.games_end[match].league.name)
                }
            }
        }
       // print(leagueArr)
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(api: ApiManager())
    }
}
