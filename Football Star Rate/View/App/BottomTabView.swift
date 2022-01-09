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
  //  @StateObject var teamVM = TeamViewModel(api: ApiManager())
  //  @State var root = Root()
  //  @State var odds: [Odds] = []
    @State var onScreen = false
    var body: some View {
            ZStack(alignment:.bottom) {
                switch viewRouter.currentPage {
                case .main:
                    ZStack{
                        if api.loading || api.againLoading {
                            MainView(api: api)
                            ProgressView("Please wait...")
                                .foregroundColor(.white)
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        }else if onScreen {
                            MainView(api: api)
                                .onAppear {
                                    onScreen = false
                                }
                        }
                        else {
                            MainView(api: api)
                                .onAppear{
                                    isLoaded = true
                                    if api.isPast {
                                        api.fetchPastOdd(gamesEnd: api.completedRoot.games_end)
                                    } else {
                                        api.fetchOdd(gamesPre: api.root.games_pre)
                                    }
                                   // print(api.oddRoot)
                                    api.getTeam()
                                    onScreen = false
                                    print(viewRouter.currentPage)
                                }
                        }
                    }
                case .team:
                    TeamView(api: api)
//                        .onChange(of: api.teams.count, perform: { newValue in
//                            api.getTeam()
//                        })
                        .onAppear{
                            onScreen = true
                            api.getTeam()
                            print(viewRouter.currentPage)
                        }
                       
                case .favorite:
                    FavoriteView(api: api)
                        .onAppear {
                            onScreen = true
                            print(viewRouter.currentPage)
                        }
                 }
                VStack(){
                    Spacer()
                    TabComponent(viewRouter: viewRouter)
                }
            }.edgesIgnoringSafeArea(.bottom)
            .onAppear(){
                if !isLoaded{
                    api.fetchSource(date: api.apiDate(date: Date()))
                }
            }
        }
}


struct BottomTabView_Previews: PreviewProvider {
    static var previews: some View {
        BottomTabView(viewRouter: ViewRouter())
           // .previewInterfaceOrientation(.portrait)
            
    }
}
