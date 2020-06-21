//
//  UserPicture.swift
//  Celo
//
//  Created by Viajeros Lado B on 18/06/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import Foundation
import CoreData

struct UserPictureViewModel: Codable {
    var large: String?
    var medium: String?
    var thumbnail: String?
}

class UserPicture: NSManagedObject {
    @NSManaged var large: String?
    @NSManaged var medium: String?
    @NSManaged var thumbnail: String?
}
