//
//  E+Storyboard.swift
//  Vero-TaskApp
//
//  Created by MacBook on 30/03/2023.
//  Copyright © 2023 SamarAkkila. All rights reserved.
//

import Foundation

enum StoryboardType {
    
    case Main
    
    var name : String {
        switch self {
        case .Main : return "Main"
        }
    }
}
