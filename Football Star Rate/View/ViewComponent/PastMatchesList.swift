//
//  PastMatchesList.swift
//  Football Star Rate
//
//  Created by Sazza on 26/12/21.
//

import SwiftUI

struct PastMatchesList: View {
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
                        Text("Manchester United")
                            .foregroundColor(Color("Green"))
                        .font(.system(size: 18, weight: .light, design: .rounded))
                    }
                        
                    HStack {
                        Image("arrowWin")
                            .resizable()
                            .frame(width: 10, height: 10)
                            .opacity(0)
                            .padding(.trailing)
                        Text("Liverpool")
                            .foregroundColor(.white)
                        .font(.system(size: 18, weight: .light, design: .rounded))
                    }
                }
                Spacer()
                HStack{
                    MiniRectangle(text: "1.87")
                    MiniRectangle(text: "5.60")
                }
                .padding(.trailing)
            }
          // .padding(.horizontal)
        }
    }
}

struct PastMatchesList_Previews: PreviewProvider {
    static var previews: some View {
        PastMatchesList()
    }
}
