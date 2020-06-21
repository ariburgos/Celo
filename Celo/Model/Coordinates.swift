//
//  Coordinates.swift
//  Celo
//
//  Created by Viajeros Lado B on 18/06/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import Foundation
import CoreData

struct CoordinatesViewModel: Codable{
    var latitude: String?
    var longitude: String?
}

class Coordinates: NSManagedObject {
    @NSManaged var latitude: String?
    @NSManaged var longitude: String?
}
