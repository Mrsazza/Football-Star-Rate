//
//  PastMatchesList.swift
//  Football Star Rate
//
//  Created by Sazza on 26/12/21.
//

import SwiftUI

struct PastMatchesList: View {
    
    @State var homeTeam = "Flamingo"
    @State var awayTeam = "Palmeiros"
    @State var homeOd = "N/A"
    @State var awayOd = "N/A"
    @State var score = "0:0"
    @State var homeScore = 0
    @State var awayScore = 0
    
    private func dissectScore(score: String){
        let delimiter = ":"
        let token = score.components(separatedBy: delimiter)
        homeScore = Int(token[0]) ?? 0
        awayScore = Int(token[1]) ?? 0
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.accentColor)
            .frame(width: nil, height: 100)
            HStack{
                VStack(alignment:.leading, spacing:20){
                    HStack {
                        Image("arrowWin")
                            .resizable()
                            .frame(width: 10, height: 10)
                            .padding(.trailing)
                            .opacity(homeScore > awayScore ? 1 : 0)
                        Text(homeTeam)
                            .foregroundColor(homeScore > awayScore ? Color("Green") : .white)
                        .font(.system(size: 18, weight: .light, design: .rounded))
                    }
                        
                    HStack {
                        Image("arrowWin")
                            .resizable()
                            .frame(width: 10, height: 10)
                            .opacity(homeScore < awayScore ? 1 :0)
                            .padding(.trailing)
                        Text(awayTeam)
                            .foregroundColor(homeScore < awayScore ? Color("Green") : .white)
                        .font(.system(size: 18, weight: .light, design: .rounded))
                    }
                }
                Spacer()
                HStack{
                    MiniRectangle(text: homeOd)
                    MiniRectangle(text: awayOd)
                }
                .padding(.trailing)
            }
          // .padding(.horizontal)
        }
        .onAppear{
            if score == ":" || score == ""{
                dissectScore(score: "0:0")
            }else {
                dissectScore(score: score)
            }
        }
    }
}

struct PastMatchesList_Previews: PreviewProvider {
    static var previews: some View {
        PastMatchesList()
    }
}
