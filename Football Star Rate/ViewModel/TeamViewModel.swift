//
//  TeamViewModel.swift
//  Football Star Rate
//
//  Created by Sazza on 6/1/22.
//

import Foundation
import SwiftUI

class TeamViewModel:ObservableObject{
    
    //var team:TeamData = TeamData()
    @ObservedObject var api: ApiManager
    init(api : ApiManager){
        self.api = api
        //getTeam()
    }
 
 
}
