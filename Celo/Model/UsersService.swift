//
//  UsersService.swift
//  Celo
//
//  Created by Viajeros Lado B on 18/06/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol UsersServiceProtocol: NSObjectProtocol {
    func getUsers(page: Int, limit: Int, completion: @escaping ([UserViewModel]?, UsersAPI.UsersAPIError?) -> ())
}

class UsersService: NSObject, UsersServiceProtocol {
    var container: NSPersistentContainer!
    
    //MARK: Init with dependency for Unit tests.
    init(container: NSPersistentContainer) {
        self.container = container
        self.container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    override init() {
        container = NSPersistentContainer(name: "Celo")
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
    }
    
    func getUsers(page: Int, limit: Int, completion: @escaping ([UserViewModel]?, UsersAPI.UsersAPIError?) -> ()) {
        
        // Try load saved data
        let storedUsers = self.loadUser(page: page, limit: limit)
        if storedUsers.count == limit {
            completion(storedUsers, nil)
            return
        }
        
        UsersAPI.shared.getUsers(page: page, limit: limit) { (data, error) in
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, .genericError)
                return
            }
            
            let usersResponse = try? JSONDecoder().decode(UsersResponse.self, from: data)
            
            // Save users
            if let users = usersResponse!.results {
                for user in users {
                    self.saveUser(userLocal: user)
                }
            }
            
            completion(usersResponse?.results, nil)
        }
    }
    
    func saveUser(userLocal: UserViewModel) {
        self.container.viewContext.performAndWait {
            let managedContext = container.viewContext
            
            // User
            let entityuser =
                NSEntityDescription.entity(forEntityName: "User",
                                           in: managedContext)!
            
            let user = NSManagedObject(entity: entityuser,
                                       insertInto: managedContext)
            
            // Name
            let entityName =
                NSEntityDescription.entity(forEntityName: "UserName",
                                           in: managedContext)!
            
            let name = NSManagedObject(entity: entityName,
                                       insertInto: managedContext)
            
            name.setValue(userLocal.name?.first, forKey: "first")
            name.setValue(userLocal.name?.last, forKey: "last")
            name.setValue(userLocal.name?.title, forKey: "title")
            
            // Street
            let entityStreet =
                NSEntityDescription.entity(forEntityName: "LocationStreet",
                                           in: managedContext)!
            
            let street = NSManagedObject(entity: entityStreet,
                                         insertInto: managedContext)
            
            street.setValue(userLocal.location?.street?.number, forKey: "number")
            street.setValue(userLocal.location?.street?.name, forKey: "name")
            
            // Coordinates
            let entityCoordinates =
                NSEntityDescription.entity(forEntityName: "Coordinates",
                                           in: managedContext)!
            
            let coordinates = NSManagedObject(entity: entityCoordinates,
                                              insertInto: managedContext)
            
            coordinates.setValue(userLocal.location?.coordinates?.latitude, forKey: "latitude")
            coordinates.setValue(userLocal.location?.coordinates?.longitude, forKey: "longitude")
            
            // TimeZone
            let entityTimeZone =
                NSEntityDescription.entity(forEntityName: "LocationTimeZone",
                                           in: managedContext)!
            
            let timezone = NSManagedObject(entity: entityTimeZone,
                                           insertInto: managedContext)
            
            timezone.setValue(userLocal.location?.timezone?.offset, forKey: "offset")
            timezone.setValue(userLocal.location?.timezone?.descriptionValue, forKey: "descriptionValue")
            
            // Location
            let entityLocation =
                NSEntityDescription.entity(forEntityName: "UserLocation",
                                           in: managedContext)!
            
            let location = NSManagedObject(entity: entityLocation,
                                           insertInto: managedContext)
            
            location.setValue(street, forKey: "street")
            location.setValue(userLocal.location?.city, forKey: "city")
            location.setValue(userLocal.location?.state, forKey: "state")
            location.setValue(userLocal.location?.country, forKey: "country")
            location.setValue(coordinates, forKey: "coordinates")
            location.setValue(timezone, forKey: "timezone")
            
            // DOB
            let entityDate =
                NSEntityDescription.entity(forEntityName: "UserDate",
                                           in: managedContext)!
            
            let date = NSManagedObject(entity: entityDate,
                                       insertInto: managedContext)
            
            date.setValue(userLocal.dob?.date, forKey: "date")
            
            
            // Picture
            let entityPicture =
                NSEntityDescription.entity(forEntityName: "UserPicture",
                                           in: managedContext)!
            
            let picture = NSManagedObject(entity: entityPicture,
                                          insertInto: managedContext)
            
            picture.setValue(userLocal.picture?.large, forKey: "large")
            picture.setValue(userLocal.picture?.medium, forKey: "medium")
            picture.setValue(userLocal.picture?.thumbnail, forKey: "thumbnail")
            
            
            // Set values
            user.setValue(userLocal.gender, forKey: "gender")
            user.setValue(name, forKey: "name")
            user.setValue(location, forKey: "location")
            user.setValue(userLocal.email, forKeyPath: "email")
            user.setValue(date, forKey: "dob")
            user.setValue(userLocal.phone, forKeyPath: "phone")
            user.setValue(userLocal.cell, forKeyPath: "cell")
            user.setValue(picture, forKey: "picture")
            user.setValue(userLocal.nat, forKeyPath: "nat")
            
            
            // Save
            do {
                try managedContext.save()
                
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    func loadUser(page: Int, limit: Int) -> [UserViewModel] {
        let managedContext = container.viewContext
        let request: NSFetchRequest<User> = User.fetchRequest() as! NSFetchRequest<User>
        
        request.fetchLimit = limit
        request.fetchOffset = page * limit
        if let users = try? managedContext.fetch(request) {
            var response: [UserViewModel] = []
            for user in users {
                response.append(UserViewModel(user: user))
            }
            return response
        }
        return []
    }
}

