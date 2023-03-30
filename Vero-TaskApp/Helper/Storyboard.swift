//
//  Storyboard.swift
//  Vero-TaskApp
//
//  Created by MacBook on 30/03/2023.
//  Copyright © 2023 SamarAkkila. All rights reserved.
//

import UIKit

class Storyboard {
    
    static func instanceMain<T: UIViewController>() -> T {
        return load(from: .Main, identifier: T.self) as! T
    }

    // optionally add convenience methods for other storyboards here ...
    // ... or use the main loading method directly when
    // instantiating view controller from a specific storyboard
    
    static func load(from storyboard: StoryboardType, identifier: String) -> UIViewController {
        //let uiStoryboard = UIStoryboard(name: storyboard.name, bundle: nil)
        let uiStoryboard = loadSB(from: storyboard)
        return uiStoryboard.instantiateViewController(withIdentifier: identifier)
    }
    
    static func load(from storyboard: StoryboardType, identifier: UIViewController.Type) -> UIViewController {
        //let uiStoryboard = UIStoryboard(name: storyboard.name, bundle: nil)
        let uiStoryboard = loadSB(from: storyboard)
        return uiStoryboard.instantiateViewController(withIdentifier: String(describing: identifier))
    }
    
    static func loadSB(from storyboard: StoryboardType) -> UIStoryboard {
        return UIStoryboard(name: storyboard.name, bundle: nil)
    }
}
