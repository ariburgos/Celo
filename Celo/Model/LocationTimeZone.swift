//
//  LocationTimeZone.swift
//  Celo
//
//  Created by Viajeros Lado B on 18/06/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import Foundation
import CoreData

struct LocationTimeZoneViewModel: Codable {
    var offset: String?
    var descriptionValue: String?
}

class LocationTimeZone: NSManagedObject {
    @NSManaged var offset: String?
    @NSManaged var descriptionValue: String?
}
