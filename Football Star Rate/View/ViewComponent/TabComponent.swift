//
//  AnotherView.swift
//  Football Star Rate
//
//  Created by Sazza on 25/12/21.
//

import SwiftUI

struct TabComponent: View {
    
    @StateObject var viewRouter: ViewRouter
   // let assignedPage: Page
    
    var body: some View {

        ZStack(alignment:.bottom) {
                Image("tabRectangle")
                    .resizable()
                    .aspectRatio( contentMode: .fit)
                    .frame(width: nil)
            
            HStack(alignment:.bottom){
                    Spacer()
                VStack {
                    Image(viewRouter.currentPage == .team ? "statisticsSelected" : "statistics")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .padding(.bottom,40)
                }
                .frame(width: 100  , height: 70)
                .onTapGesture {
                    viewRouter.currentPage = Page.team
                }
                    Spacer()
                    ZStack {
                        Circle()
                            .foregroundColor(Color( viewRouter.currentPage == .main ? "Yellow" : "Blue"))
                            .frame(width: 70, height: 70)
                        Image(viewRouter.currentPage == .main ? "soccer": "soccerSelected")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                    .offset( y: -50)
                    .onTapGesture {
                        viewRouter.currentPage = Page.main
                    }
                    Spacer()
                VStack {
                    Image(viewRouter.currentPage == .favorite ? "starSelected" : "star")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .padding(.bottom,40)
                }
                .frame(width: 100  , height: 70)
                .onTapGesture {
                    viewRouter.currentPage = Page.favorite
                }
                    Spacer()
                    
                }
            }
        .edgesIgnoringSafeArea(.all)
    }
}

struct AnotherView_Previews: PreviewProvider {
    static var previews: some View {
        TabComponent(viewRouter: ViewRouter())
    }
}
