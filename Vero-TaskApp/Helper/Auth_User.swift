//
//  Auth_User.swift
//  Vero-TaskApp
//
//  Created by MacBook on 27/03/2023.
//  Copyright © 2023 SamarAkkila. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

struct Auth_User {
    
    static var userToken: String {
        get { return UserDefaults.standard[.UserToken] ?? "" }
        set { UserDefaults.standard[.UserToken] = newValue }
    }
    
}
