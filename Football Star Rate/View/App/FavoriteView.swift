//
//  FavoriteView.swift
//  Football Star Rate
//
//  Created by Sazza on 25/12/21.
//

import SwiftUI

struct FavoriteView: View {
    @StateObject var api:ApiManager
    var body: some View {
        ZStack {
            Color.accentColor
            VStack(spacing:0){
                TopBar(tabName: "Favorite team")
                    List {
                        ForEach(0..<5, id:\.self){ i in
                                ZStack {
                                    Rectangle()
                                        .foregroundColor( (i % 2 == 0) ? Color.accentColor : Color("DarkBlue"))
                                    .frame(width: nil, height: 90)
                                    
                                    HStack{
                                        Image(systemName: "circle.fill")
                                            .resizable()
                                            .foregroundColor(.white)
                                            .frame(width: 50, height: 50)
                                        
                                        Text("Real Madrid")
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
                                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .listRowBackground(Color.accentColor)
                        }.onDelete(perform: removeRows)
                    }.listStyle(.plain)
                Spacer()
            }
        }
    }
    
    func removeRows(at offsets: IndexSet) {
       // numbers.remove(atOffsets: offsets)
    }
}


struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView(api: ApiManager())
    }
}
