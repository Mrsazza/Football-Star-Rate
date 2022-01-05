//
//  ViewRouter.swift
//  Football Star Rate
//
//  Created by Sazza on 25/12/21.
//

import Foundation
import SwiftUI

enum Page {
     case main
     case team
     case favorite
 }

class ViewRouter: ObservableObject {
    @Published var currentPage: Page = .main
}
