//
//  UsersListPresenter.swift
//  Celo
//
//  Created by Viajeros Lado B on 18/06/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import Foundation
import UIKit

protocol UserListViewProtocol: NSObjectProtocol {
    func onFetchCompleted(with indexPath: [IndexPath])
    func reloadTable()
    func showMessage(message: String)
    func showLoading()
    func hideLoading()
}

class UsersListPresenter {
    private struct Constants {
        static let paginationLimit = 20
    }
    
    private var page = 0
    private var isFetching = false
    
    private let userService: UsersServiceProtocol
    private var users: [UserViewModel] = []
    private var filteredUsers: [UserViewModel] = []

    
    weak private var view : UserListViewProtocol?
    
    init(userService: UsersServiceProtocol){
        self.userService = userService
    }
    
    func attachView(view: UserListViewProtocol?){
        self.view = view
    }
    
    func numberOfItems(isFiltering: Bool) -> Int {
        if isFiltering {
          return filteredUsers.count
        }
        return users.count
    }
    
    func user(atIndex index: Int, isFiltering: Bool) -> (name: String, gender: String, birthday: String, imageURL: URL?) {
        let usersArray: [UserViewModel] = isFiltering ? filteredUsers : users
        
        let completeName =  usersArray[index].name?.toString() ?? ""
        
        var formatedBirthday: String = ""
        if let birthday = usersArray[index].dob?.date {
            formatedBirthday = DateFormatter.fullFormatStringToString(string: birthday, format: .prettyDate)
        }
        
        var imageURL: URL?
        if let thumbnailStringUrl = usersArray[index].picture?.thumbnail {
            imageURL = URL(string: thumbnailStringUrl)
        }
        
        let gender = usersArray[index].gender ?? ""
        return (name: completeName, gender: gender, birthday: formatedBirthday, imageURL: imageURL)
    }
    
    func prefetchItems() {
        if !isFetching {
            view?.showLoading()
            isFetching = true
            userService.getUsers(page: page, limit: Constants.paginationLimit, completion: {[weak self] (users, error) in
                if let users = users,
                    let indexPath = self?.calculateIndexPathsToReload(from: users) {
                    
                    self?.users += users
                    self?.page += 1
                    self?.isFetching = false
                    self?.view?.onFetchCompleted(with: indexPath)
                    self?.view?.hideLoading()
                } else {
                    self?.view?.hideLoading()
                    self?.view?.showMessage(message: "we are trying to solve the problem, Try later.")
                }
            })
        }
        
    }
    
    func userData(forIndex index: Int) -> UserViewModel {
        return users[index]
    }
    
    func filterContentForSearchText(_ searchText: String) {
      filteredUsers = users.filter { (user: UserViewModel) -> Bool in
        return user.name?.toString().lowercased().contains(searchText.lowercased()) ?? false
      }
        view?.reloadTable()
    }

    // MARK:- Private
    private func calculateIndexPathsToReload(from newUsers: [UserViewModel]) -> [IndexPath] {
      let startIndex = users.count
      let endIndex = startIndex + newUsers.count
      return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
}
