//
//  UserLocation.swift
//  Celo
//
//  Created by Viajeros Lado B on 18/06/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import Foundation
import CoreData

struct UserLocationViewModel: Codable {
     var street: LocationStreetViewModel?
     var city: String?
     var state: String?
     var country: String?
     var coordinates: CoordinatesViewModel?
     var timezone: LocationTimeZoneViewModel?
    
    func toString() -> String {
        var numberString = ""
        if let number = street?.number {
            numberString = String(number)
        }
        
        return String(format: "%@ %@ - %@ - %@",
                      numberString,
                      street?.name ?? "",
                      city ?? "",
                      country ?? "")
    }
}

class UserLocation: NSManagedObject {
    @NSManaged var street: LocationStreet?
    @NSManaged var city: String?
    @NSManaged var state: String?
    @NSManaged var country: String?
    @NSManaged var coordinates: Coordinates?
    @NSManaged var timezone: LocationTimeZone?
}
