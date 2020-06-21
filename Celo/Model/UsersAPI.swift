//
//  UsersAPI.swift
//  Celo
//
//  Created by Viajeros Lado B on 18/06/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import Foundation

struct UsersAPI {
    static let shared = UsersAPI()
    private init() {}
    
    struct Constants {
        static let usersURL = "https://randomuser.me/api/"
        static let seed = "CELO"
    }
    
    enum UsersAPIError {
        case notFound
        case noInternetConnection
        case genericError
    }
    
    func getUsers(page: Int, limit: Int, completion: @escaping (Data?, UsersAPIError?) -> ()) {
        DispatchQueue.global(qos: .background).async {
            let queryItems = [URLQueryItem(name: "page", value: String(page)),
                              URLQueryItem(name: "results", value: String(limit)),
                              URLQueryItem(name: "seed", value: Constants.seed)]
            let usersURLComponent = NSURLComponents(string: Constants.usersURL)!
            usersURLComponent.queryItems = queryItems
            
            
            HTTPConnector.shared.fetchData(url: usersURLComponent.url!) { (data, error) in
                if let error = error {
                    self.handleError(error: error, completion: completion)
                }
                DispatchQueue.main.async {
                    completion(data, nil)
                }
            }
            
        }
    }
    
    private func handleError(error: HTTPConnectorError, completion: @escaping (Data?, UsersAPIError?) -> ()) {
        DispatchQueue.main.async {
            if case let .invalidRequest(code) = error,
                code == 404 {
                completion(nil, .notFound)
            }
                
            else if case let .unknownError(error) = error,
                let nsError = error as NSError?,
                nsError.code == -1009 {
                completion(nil, .noInternetConnection)
            }
                
            else {
                completion(nil, .genericError)
            }
        }
    }
}
