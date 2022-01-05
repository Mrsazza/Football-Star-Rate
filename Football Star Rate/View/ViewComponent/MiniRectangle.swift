//
//  MiniRectangle.swift
//  Football Star Rate
//
//  Created by Sazza on 25/12/21.
//

import SwiftUI

struct MiniRectangle: View {
    @State var text: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(Color("Blue"))
            .frame(width: 60, height: 35)
            Text(text)
                .foregroundColor(.white)
        }
    }
}

struct MiniRectangle_Previews: PreviewProvider {
    static var previews: some View {
        MiniRectangle(text: String())
    }
}
