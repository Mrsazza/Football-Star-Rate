//
//  LoadImage.swift
//  Football Star Rate
//
//  Created by Sazza on 29/12/21.
//

import SwiftUI

struct LoadImage: View {
    
    @ObservedObject var imageLoader:ImageLoader
    @State var image:UIImage = UIImage()
 //   @State var nameIn: String
    
    init(withURL teamId:String) {
           imageLoader = ImageLoader(urlString:"https://spoyer.ru/api/team_img/soccer/\(teamId).png")
            //nameIn = name
       }
    
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .foregroundColor(.white)
            .frame(width: 50, height: 50)
            .onReceive(imageLoader.didChange) { data in
                 self.image = UIImage(data: data) ?? UIImage()
             }
    }
}
