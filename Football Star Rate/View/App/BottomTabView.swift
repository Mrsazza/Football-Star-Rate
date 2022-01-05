//
//  MainView.swift
//  Football Star Rate
//
//  Created by Sazza on 24/12/21.
//

import SwiftUI

struct BottomTabView: View {
    
    @StateObject var viewRouter: ViewRouter
    @StateObject var api = ApiManager()
    @State var isLoaded = false
    @StateObject var OddsVM = OddsViewModel()
  //  @State var root = Root()
  //  @State var odds: [Odds] = []
    
    var body: some View {
            ZStack(alignment:.bottom) {
                switch viewRouter.currentPage {
                case .main:
                    ZStack{
                        if api.loading || api.againLoading{
                            MainView(api: api)
                            ProgressView("Please wait...")
                                .foregroundColor(.white)
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        } else {
                            MainView(api: api)
                                .onAppear{
                                    api.fetchOdd(gamesPre: api.root.games_pre)
                                   // print(api.oddRoot)
                                }
                        }
                    }
                case .team:
                    TeamView(api: api)
                case .favorite:
                    FavoriteView(api: api)
                 }
                VStack(){
                    Spacer()
                    TabComponent(viewRouter: viewRouter)
                }
            }.edgesIgnoringSafeArea(.bottom)
            .onAppear(){
                api.fetchSource(date: api.apiDate(date: Date()))
            }
        }
}


struct BottomTabView_Previews: PreviewProvider {
    static var previews: some View {
        BottomTabView(viewRouter: ViewRouter())
            .previewInterfaceOrientation(.portrait)
            
    }
}
