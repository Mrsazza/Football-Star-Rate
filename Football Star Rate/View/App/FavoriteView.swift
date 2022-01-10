//
//  FavoriteView.swift
//  Football Star Rate
//
//  Created by Sazza on 25/12/21.
//

import SwiftUI

struct FavoriteView: View {
    @ObservedObject var api:ApiManager
    @StateObject var teamVM = TeamVM()
    var body: some View {
        NavigationView{
        ZStack {
            Color.accentColor
            VStack(spacing:0){
                TopBar(tabName: "Favorite team")
                    List {
                        ForEach(0..<teamVM.favoriteTeam.count, id:\.self){ i in
                                ZStack {
                                    NavigationLink(destination: TeamDetailView(api: api, teamId: teamVM.favoriteTeam[i].id, name: teamVM.favoriteTeam[i].name, cc: teamVM.favoriteTeam[i].cc!)){
                                        EmptyView()}
                                    
                                    Rectangle()
                                        .foregroundColor( (i % 2 == 0) ? Color.accentColor : Color("DarkBlue"))
                                    .frame(width: nil, height: 90)
                                    
                                    HStack{
                                        LoadImage(withURL: teamVM.favoriteTeam[i].id)
                                        
                                        Text(teamVM.favoriteTeam[i].name)
                                            .foregroundColor(.white)
                                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                                            .padding(.leading,10)
                                        Spacer()
//                                        Text("\(teamVM.favoriteTeam[i].chance)")
//                                            .foregroundColor(.white)
//                                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                                    }
                                    .padding()
                                }
                                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .listRowBackground(Color.accentColor)
                        }.onDelete(perform: teamVM.removeRows)
                    }.listStyle(.plain)
                Spacer()
            }
            }
        .navigationBarHidden(true)
        }
    }
}


struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView(api: ApiManager(), teamVM: TeamVM())
    }
}
