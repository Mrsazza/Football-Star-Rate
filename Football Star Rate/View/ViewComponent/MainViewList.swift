//
//  MainViewList.swift
//  Football Star Rate
//
//  Created by Sazza on 25/12/21.
//

import SwiftUI

struct MainViewList: View {
    
    @State var homeTeam = "Flamingo"
    @State var awayTeam = "Palmeiros"
    @State var homeOd = "N/A"
    @State var awayOd = "N/A"
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.accentColor)
            .frame(width: nil, height: 100)
            HStack{
                VStack(alignment:.leading, spacing:20){
                    Text(homeTeam)
                        .foregroundColor(Color(.systemGray))
                        
                    Text(awayTeam)
                        .foregroundColor(Color(.systemGray))
                }
                Spacer()
                HStack{
                    MiniRectangle(text: homeOd)
                    MiniRectangle(text: awayOd)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct MainViewList_Previews: PreviewProvider {
    static var previews: some View {
        MainViewList()
    }
}
