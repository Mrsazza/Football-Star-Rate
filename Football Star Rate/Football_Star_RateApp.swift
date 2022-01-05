//
//  Football_Star_RateApp.swift
//  Football Star Rate
//
//  Created by Sazza on 24/12/21.
//

import SwiftUI

@main
struct Football_Star_RateApp: App {
    
    @StateObject var viewRouter = ViewRouter()
    
    var body: some Scene {
        WindowGroup {
            BottomTabView(viewRouter: viewRouter)
        }
    }
}
