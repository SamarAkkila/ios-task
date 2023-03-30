//
//  Task+CoreDataProperties.swift
//  Vero-TaskApp
//
//  Created by MacBook on 27/03/2023.
//  Copyright © 2023 SamarAkkila. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var task: String?
    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var sort: String?
    @NSManaged public var wageType: String?
    @NSManaged public var businessUnitKey: String?
    @NSManaged public var businessUnit: String?
    @NSManaged public var parentTaskID: String?
    @NSManaged public var preplanningBoardQuickSelect: String?
    @NSManaged public var colorCode: String?
    @NSManaged public var workingTime: String?
    @NSManaged public var isAvailableInTimeTrackingKioskMode: Bool

}

extension Task : Identifiable {

}
