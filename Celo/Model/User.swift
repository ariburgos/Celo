//
//  User.swift
//  Celo
//
//  Created by Viajeros Lado B on 18/06/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct UsersResponse: Codable {
    var results: [UserViewModel]?
}

struct UserViewModel: Codable {
    var gender: String?
    var name: UserNameViewModel?
    var location: UserLocationViewModel?
    var email: String?
    var dob: UserDateViewModel?
    var phone: String?
    var cell: String?
    var picture: UserPictureViewModel?
    var nat: String?
    
    init(user: User) {
        gender = user.gender
        name = UserNameViewModel(title: user.name?.title, first: user.name?.first, last: user.name?.last)
        
        let street = LocationStreetViewModel(number: user.location?.street?.number as? Int, name: user.location?.street?.name)
        let coordinates = CoordinatesViewModel(latitude: user.location?.coordinates?.latitude, longitude: user.location?.coordinates?.longitude)
        let timezone = LocationTimeZoneViewModel(offset: user.location?.timezone?.offset, descriptionValue: user.location?.timezone?.descriptionValue)
        location = UserLocationViewModel(street: street, city: user.location?.city, state: user.location?.state, country: user.location?.country, coordinates: coordinates, timezone: timezone)
        
        email = user.email
        dob = UserDateViewModel(date: user.dob?.date)
        phone = user.phone
        cell = user.cell
        picture = UserPictureViewModel(large: user.picture?.large, medium: user.picture?.medium, thumbnail: user.picture?.thumbnail)
        nat = user.nat
    }
}

class User: NSManagedObject {
    @NSManaged var gender: String?
    @NSManaged var name: UserName?
    @NSManaged var location: UserLocation?
    @NSManaged var email: String?
    @NSManaged var dob: UserDate?
    @NSManaged var phone: String?
    @NSManaged var cell: String?
    @NSManaged var picture: UserPicture?
    @NSManaged var nat: String?
}
