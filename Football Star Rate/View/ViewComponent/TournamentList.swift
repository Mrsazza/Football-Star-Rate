//
//  TournamentList.swift
//  Football Star Rate
//
//  Created by Sazza on 25/12/21.
//

import SwiftUI

struct TournamentList: View {
    
    @State var leagueArray: [String] = []
    @State var isSelected = false
    @Binding var selectedLeague :String
    var body: some View {
        VStack(spacing:0){
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color("Green"))
                .frame(width: 320, height: 70)
                Text("Choose League")
                    .foregroundColor(.white)
                    .padding(.horizontal)
            }
            .onTapGesture{
                selectedLeague = ""
            }
            ScrollView {
                ForEach(leagueArray, id:\.self){ league in
                    ZStack(alignment:.leading){
                        Rectangle()
                            .foregroundColor(selectedLeague == league ? Color("Green"):Color("Blue"))
                            .frame(width: 320, height: 70)
                        Text(league)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                    }
                    .onTapGesture {
                        print(league)
                        selectedLeague = league
                        isSelected.toggle()
                    }
                    .padding(.bottom, -20)
                }
            }
        }
    }
}

struct TournamentList_Previews: PreviewProvider {
    @State static var selectedLeague:String = ""
    static var previews: some View {
        TournamentList(selectedLeague: $selectedLeague)
    }
}
