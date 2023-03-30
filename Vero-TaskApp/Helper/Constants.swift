//
//  Constants.swift
//  Vero-TaskApp
//
//  Created by MacBook on 29/03/2023.
//  Copyright © 2023 SamarAkkila. All rights reserved.
//

import Foundation

class Constants{
    
    static let apiDomain = "https://api.baubuddy.de"
    
    static let login = apiDomain + "/index.php/login"
    static let tasks = apiDomain + "/dev/index.php/v1/tasks/select"
    
    
    static let stopRefresh = Notification.Name("vero.stopRefresh")
}
