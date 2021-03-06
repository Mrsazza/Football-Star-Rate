//
//  TeamDetailView.swift
//  Football Star Rate
//
//  Created by Sazza on 26/12/21.
//

import SwiftUI

struct TeamDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var api: ApiManager
    @ObservedObject var teamVM = TeamVM()
    @State var teamId: String
    @State var name: String
    @State var cc: String
    var body: some View {
        ZStack{
            Color.accentColor
            VStack(spacing:0){
                ZStack {
                    TopBar(tabName: "Team")
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image("arrowBack")
                                .resizable()
                                .frame(width: 10, height: 15)
                        })
                        Spacer()
                        
                        Image( teamVM.favoriteTeam.contains(where: {$0.id == teamId}) ? "starSelected" : "star")
                            .onTapGesture {
                                if (teamVM.favoriteTeam.contains(where: {$0.id == teamId})){
                                    //
                                }else {
                                    teamVM.add(TeamData(name: name, id: teamId, cc: cc))
                                }
                            }
                    }
                    .padding()
                }
                TeamDetail(withURL: teamId, name: name,cc: countryCode[cc] ?? "")
                
                MidlleBar(barName: "Upcoming")
                if api.teamLoading{
                    ProgressView("Fetching Data...")
                        .foregroundColor(.white)
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .padding()
                } else {
                    if api.teamUpcomingRoot.games_pre.count == 0{
                        Text("No Data")
                            .foregroundColor(.white)
                            .font(.callout)
                            .padding()
                    } else {
                       
                     
                        
                        ScrollView {
                            if api.oddLoading{
                                ProgressView("Fetching Odds...")
                                    .foregroundColor(.white)
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .padding()
                            } else {
                                ForEach(api.teamUpcomingRoot.games_pre, id:\.id){(match) in
                                    if (api.teamOddArr.contains(where: {$0.gameId == match.game_id})){
                                        MainViewList(homeTeam: match.home.name, awayTeam: match.away.name,homeOd: api.teamOddArr[api.teamOddArr.firstIndex(where: {$0.gameId == match.game_id})!].homeOd,awayOd: api.teamOddArr[api.teamOddArr.firstIndex(where: {$0.gameId == match.game_id})!].awayOd)
                                    }
                                    else{
                                        MainViewList(homeTeam: match.home.name, awayTeam: match.away.name)
                                    }
                                }
                            }
                        }
                        .onAppear{
                            // if api.teamUpcomingRoot.games_pre.count != 0{
                                 api.fetchTeamOdd(gamesPre: api.teamUpcomingRoot.games_pre)
                             //}
                            // print("api count \(api.teamOddArr.count)")
                         }
                        .frame(height:150)
                    
                    }
                }
                MidlleBar(barName: "Past Matches")
                if api.teamPastLoading{
                    ProgressView("Fetching Data...")
                        .foregroundColor(.white)
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .padding()
                } else{
//                    Group{
//                        if api.completedRoot.games_end.isEmpty {
//                        EmptyView()
//                      }
//                    else{
                ScrollView{
                    if api.oddPastLoading{
                        ProgressView("Fetching Matches..")
                            .foregroundColor(.white)
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .padding()
                    } else {
                    ForEach(api.teamPastRoot.games_end, id: \.id){(match) in
                        if (api.teamPastOddArr.contains(where: {$0.gameId == match.game_id})){
                            PastMatchesList(homeTeam: match.home.name,
                                            awayTeam: match.away.name,
                                            homeOd: api.teamPastOddArr[api.teamPastOddArr.firstIndex(where: {$0.gameId == match.game_id})!].homeOd,
                                            awayOd: api.teamPastOddArr[api.teamPastOddArr.firstIndex(where: {$0.gameId == match.game_id})!].awayOd,score: match.score)
                        }
                        else{
                            PastMatchesList(homeTeam: match.home.name, awayTeam: match.away.name,score:match.score)
                        }
                    }
                }
                    
                }
                .onAppear {
                    api.fetchTeamPastOdd(gamesEnd: api.teamPastRoot.games_end)
                }
//                }
//
//            }
            }
                
                Spacer()
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        .onAppear{
            api.fetchTeamUpcoming(teamId: teamId)
            api.fetchTeamPast(teamId: teamId)
        }
    }
}

struct TeamDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TeamDetailView(api: ApiManager(), teamId: String(), name: String(), cc: String())
    }
}

struct TeamDetail: View{
    
    @ObservedObject var imageLoader:ImageLoader
    @State var image:UIImage = UIImage()
    @State var nameIn: String
    @State var cc: String
    init(withURL teamId:String, name:String, cc: String) {
        imageLoader = ImageLoader(urlString:"https://spoyer.ru/api/team_img/soccer/\(teamId).png")
        nameIn = name
        self.cc = cc
    }
    
    var body: some View{
        HStack{
            ZStack{
                Rectangle()
                    .foregroundColor(Color("DarkBlue"))
                    .frame(width: 120, height: 120)
                Image(uiImage: image)
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 90, height: 90)
                    .onReceive(imageLoader.didChange) { data in
                        self.image = UIImage(data: data) ?? UIImage()
                    }
                
            }.padding(.horizontal)
            VStack(alignment: .leading, spacing:8){
                Text(nameIn)
                    .foregroundColor(Color(.systemGray3))
                    .font(.system(size: 24, weight: .light, design: .rounded))
                Text(cc)
                    .foregroundColor(Color("Green"))
                    .font(.system(size: 20, weight: .medium, design: .rounded))
            }
            Spacer()
        }
        .padding(.horizontal)
        .frame(width: nil, height: 200)
    }
}
