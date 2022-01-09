//
//  MatchDetailView.swift
//  Football Star Rate
//
//  Created by Sazza on 25/12/21.
//

import SwiftUI

struct MatchDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var api : ApiManager
    @State var game: GamesPre = GamesPre()
    @State var gameEnd: GamesEnd = GamesEnd()
    @State var homeOd = "N/A"
    @State var awayOd = "N/A"
    @State var drawOd = "N/A"
    
    var body: some View {
        NavigationView {
            ZStack{
                Color.accentColor
                VStack(spacing:0) {
                    ZStack {
                        TopBar(tabName: "Match")
                        HStack {
                                Button(action: {
                                    presentationMode.wrappedValue.dismiss()
                                }, label: {
                                    Image("arrowBack")
                                        .resizable()
                                        .frame(width: 10, height: 15)
                            })
                            Spacer()
                        }
                        .padding()
                    }
                    HStack{
                        Spacer()
                            .frame(width:40)
                        NavigationLink(destination: TeamDetailView(api: api, teamId: api.isPast ? gameEnd.home.id : game.home.id, name: api.isPast ? gameEnd.home.name : game.home.name,cc: api.isPast ? gameEnd.home.cc! : game.home.cc!)) {
                            Team(withURL: api.isPast ? gameEnd.home.id : game.home.id,name: api.isPast ? gameEnd.home.name : game.home.name)
                        }
                        Spacer()
                            .frame(width:30)
                        VStack(spacing: 10){
                            Text(gameDate(time: api.isPast ? gameEnd.time : game.time))
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .semibold, design: .rounded))
                            Text(gameTime(time: api.isPast ? gameEnd.time : game.time))
                                .foregroundColor(Color("Green"))
                                .font(.system(size: 22, weight: .semibold, design: .rounded))
                        }
                        Spacer()
                            .frame(width:30)
                        NavigationLink(destination: TeamDetailView(api: api, teamId: api.isPast ? gameEnd.away.id : game.away.id, name: api.isPast ? gameEnd.away.name : game.away.name,cc: api.isPast ? gameEnd.away.cc! : game.away.cc!)) {
                            Team(withURL: api.isPast ? gameEnd.away.id : game.away.id,name: api.isPast ? gameEnd.away.name : game.away.name)
                        }
                        Spacer()
                            .frame(width:40)
                    }
                    .frame(width: nil, height: 300)
                    ZStack {
                        Rectangle()
                            .frame(width: nil, height: 70)
                            .foregroundColor(Color("DarkBlue"))
                        HStack{
                            Spacer()
                            MiniRectangle(text: homeOd)
                            Spacer()
                            MiniRectangle(text: drawOd)
                            Spacer()
                            MiniRectangle(text: awayOd)
                            Spacer()
                        }
                    }
                    HStack {
                        Text("Chances")
                            .foregroundColor(.white)
                        .padding(.all, 30)
                        Spacer()
                    }
                    ZStack{
                        Rectangle()
                            .frame(width: nil, height: 70)
                            .foregroundColor(Color("DarkBlue"))
                        HStack{
                            Spacer()
                            Text("\(mainChance(homeOd:homeOd,drawOd:drawOd,awayOd:awayOd,selected: 1))%")
                                .foregroundColor(.white)
                                .font(.system(size: 20, weight: .semibold, design: .rounded))
                            Spacer()
                            Text("\(mainChance(homeOd:homeOd,drawOd:drawOd,awayOd:awayOd,selected: 2))%")
                                .foregroundColor(.white)
                                .font(.system(size: 20, weight: .semibold, design: .rounded))
                            Spacer()
                            Text("\(mainChance(homeOd:homeOd,drawOd:drawOd,awayOd:awayOd,selected: 3))%")
                                .foregroundColor(.white)
                                .font(.system(size: 20, weight: .semibold, design: .rounded))
                            Spacer()
                        }
                    }
                    Spacer()
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
       
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    
    private func mainChance(homeOd:String, drawOd:String, awayOd:String, selected:Int) -> Int{
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
    
    //returns the date in the format
    private func gameDate(time: String) -> String{
        let date = Date(timeIntervalSince1970: Double(time) ?? 1641101400)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        let day = dateFormatter.string(from: date)
        return "\(day)"
    }
    
    //returns the time in the format
    private func gameTime(time:String)->String{
        let date = Date(timeIntervalSince1970: Double(time) ?? 1641101400)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "H.m"
        let hour = dateFormatter.string(from: date)
        return "\(hour)"
    }
}

struct MatchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MatchDetailView(api: ApiManager(), game: GamesPre())
    }
}

struct Team: View {
    
    @ObservedObject var imageLoader:ImageLoader
    @State var image:UIImage = UIImage()
    @State var nameIn: String
    
    init(withURL teamId:String, name:String) {
           imageLoader = ImageLoader(urlString:"https://spoyer.ru/api/team_img/soccer/\(teamId).png")
            nameIn = name
       }
    
    
    var body: some View {
        VStack{
            ZStack{
                Rectangle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color("DarkBlue"))
                Image(uiImage: image)
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .onReceive(imageLoader.didChange) { data in
                         self.image = UIImage(data: data) ?? UIImage()
                     }
            }
            Text(nameIn)
                .foregroundColor(.white)
                .lineLimit(nil)
//                .fixedSize(horizontal: false, vertical: true)
                .font(.system(size: 18, weight: .light, design: .rounded))
        }
    }
}
