//
//  UserDate.swift
//  Celo
//
//  Created by Viajeros Lado B on 18/06/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import Foundation
import CoreData

struct UserDateViewModel: Codable {
    var date: String?
}

class UserDate: NSManagedObject {
    @NSManaged var date: String?
}
