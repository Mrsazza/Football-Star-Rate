//
//  TopBar.swift
//  Football Star Rate
//
//  Created by Sazza on 25/12/21.
//

import SwiftUI

struct TopBar: View {
    @State var tabName:String
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color("DarkBlue"))
                .frame(width: nil, height: 80)
            Text(tabName)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(.white)
        }
    }
}

struct TopBar_Previews: PreviewProvider {
    static var previews: some View {
        TopBar(tabName: String())
    }
}
