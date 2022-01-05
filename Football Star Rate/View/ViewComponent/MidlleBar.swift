//
//  MidlleBar.swift
//  Football Star Rate
//
//  Created by Sazza on 26/12/21.
//

import SwiftUI

struct MidlleBar: View {
    
    @State var barName: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: nil, height: 60)
                .foregroundColor(Color("DarkBlue"))
            HStack{
                Text(barName)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                Spacer()
            }.padding()
        }
    }
}

struct MidlleBar_Previews: PreviewProvider {
    static var previews: some View {
        MidlleBar(barName: String())
    }
}
