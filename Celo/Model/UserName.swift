//
//  UserName.swift
//  Celo
//
//  Created by Viajeros Lado B on 18/06/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import Foundation
import CoreData

struct UserNameViewModel: Codable {
    var title: String?
     var first: String?
     var last: String?
    
    func toString() -> String {
        return String(format: "%@ %@ %@",
                      title ?? "",
                      first ?? "",
                      last ?? "")
    }
}

class UserName: NSManagedObject {
    @NSManaged var title: String?
    @NSManaged var first: String?
    @NSManaged var last: String?
}
