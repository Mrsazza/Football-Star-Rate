//
//  TeamModel.swift
//  Football Star Rate
//
//  Created by Sazza on 6/1/22.
//

import Foundation


struct TeamData: Codable, Identifiable{
    
    var name: String = ""
    var id: String = ""
    var image_id: String = ""
    var cc: String? = ""
    var chance: Int = 0
}
