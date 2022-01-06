//
//  TeamView.swift
//  Football Star Rate
//
//  Created by Sazza on 25/12/21.
//

import SwiftUI

struct TeamView: View {
    @ObservedObject var api:ApiManager
    var body: some View {
        NavigationView{
        ZStack {
            Color.accentColor
            VStack(spacing: 0) {
                TopBar(tabName: "Team rating")
                if api.teams.count == 0{
                    ProgressView("Please wait...")
                        .foregroundColor(.white)
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .padding()
                } else {
                ScrollView {
                    ForEach(0..<api.teams.count){ i in
                        NavigationLink(destination: TeamDetailView( api: api, teamId: api.teams[i].id, name: api.teams[i].name, cc: api.teams[i].cc!)){
                            ZStack {
                                Rectangle()
                                    .foregroundColor( (i % 2 == 0) ? Color.accentColor : Color("DarkBlue"))
                                .frame(width: nil, height: 90)
                                
                                HStack{
                                    LoadImage(withURL: api.teams[i].id)
                                    
                                    Text(api.teams[i].name)
                                        .foregroundColor(.white)
                                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                                        .padding(.leading,10)
                                    Spacer()
                                    Text("\(api.teams[i].chance)")
                                        .foregroundColor(.white)
                                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                                }
                                .padding()
                            }
                        }
                    }
                }
                }
                Spacer()
            }
            .onChange(of: api.teams.count) { _ in
                api.getTeam()
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
