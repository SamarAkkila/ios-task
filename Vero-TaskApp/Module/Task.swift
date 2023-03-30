//
//  Task.swift
//  Vero-TaskApp
//
//  Created by MacBook on 30/03/2023.
//  Copyright © 2023 SamarAkkila. All rights reserved.
//

import Foundation

struct taskModel: Codable {
    
    let task: String?
    let title: String?
    let description : String?
    let sort: String?
    let wageType: String?
    let BusinessUnitKey: String?
    let businessUnit: String?
    let parentTaskID: String?
    let preplanningBoardQuickSelect: String?
    let colorCode: String?
    let workingTime: String?
    let isAvailableInTimeTrackingKioskMode: Bool?
    
}
