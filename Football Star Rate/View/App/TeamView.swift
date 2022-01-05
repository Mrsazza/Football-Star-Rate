//
//  TeamView.swift
//  Football Star Rate
//
//  Created by Sazza on 25/12/21.
//

import SwiftUI

struct TeamView: View {
    @StateObject var api:ApiManager
    
    var body: some View {
        NavigationView{
        ZStack {
            Color.accentColor
            VStack(spacing: 0) {
                TopBar(tabName: "Team rating")
                ScrollView {
                    ForEach(0..<api.root.games_pre.count){ i in
                        NavigationLink(destination: TeamDetailView(api: api, teamId: api.root.games_pre[i].home.id, name:  api.root.games_pre[i].home.name, cc:  api.root.games_pre[i].home.cc!)){
                            ZStack {
                                Rectangle()
                                    .foregroundColor( (i % 2 == 0) ? Color.accentColor : Color("DarkBlue"))
                                .frame(width: nil, height: 90)
                                
                                HStack{
                                    LoadImage(withURL: api.root.games_pre[i].home.id)
                                    
                                    Text(api.root.games_pre[i].home.name)
                                        .foregroundColor(.white)
                                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                                        .padding(.leading,10)
                                    Spacer()
                                    Text("92%")
                                        .foregroundColor(.white)
                                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                                }
                                .padding()
                            }
                        }
                    }
                }
                Spacer()
            }
            
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        }
    }
}

struct TeamView_Previews: PreviewProvider {
    static var previews: some View {
        TeamView(api: ApiManager())
    }
}
