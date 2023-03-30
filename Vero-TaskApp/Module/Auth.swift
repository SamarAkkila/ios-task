//
//  Model.swift
//  Vero-TaskApp
//
//  Created by MacBook on 30/03/2023.
//  Copyright © 2023 SamarAkkila. All rights reserved.
//

import Foundation

struct Response: Codable {
    let oauth: oauthModel
    let userInfo: userInfoModel
    
}

struct oauthModel: Codable {
    let access_token: String
    let token_type: String
    let refresh_token: String
    let expires_in: Int
    
}

struct userInfoModel: Codable {
    let firstName: String
    let lastName: String
    
}


