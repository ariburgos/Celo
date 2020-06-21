//
//  LocationStreet.swift
//  Celo
//
//  Created by Viajeros Lado B on 18/06/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import Foundation
import CoreData

struct LocationStreetViewModel: Codable {
    var number: Int?
    var name: String?
}

class LocationStreet: NSManagedObject {
    @NSManaged var number: NSNumber?
    @NSManaged var name: String?
}

