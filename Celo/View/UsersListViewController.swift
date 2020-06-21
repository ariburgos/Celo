//
//  UsersListViewController.swift
//  Celo
//
//  Created by Viajeros Lado B on 18/06/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import Foundation
import UIKit

class UsersListViewControlller: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let presenter = UsersListPresenter(userService: UsersService())
    
    var isSearchBarEmpty: Bool {
      return searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
      return  !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter.prefetchItems()
    }
}

extension UsersListViewControlller: UserListViewProtocol {
    func showLoading() {
        LoadingView.shared.showIndicator()
    }
    
    func hideLoading() {
        LoadingView.shared.hideIndicator()
    }
    
    func reloadTable() {
        tableView.reloadData()
    }
    
    func onFetchCompleted(with indexPath: [IndexPath]) {
        tableView.insertRows(at: indexPath, with: .automatic)
    }
    
    func showMessage(message: String) {
        showAlert(message: message)
    }
}

extension UsersListViewControlller: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems(isFiltering: isFiltering)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userViewCell") as! UserViewCell
        
        let user = presenter.user(atIndex: indexPath.row, isFiltering: isFiltering)
        cell.nameLabel.text = user.name
        cell.genderLabel.text = user.gender
        cell.dateOfBirthLabel.text = user.birthday
        if let imageURL = user.imageURL {
            cell.mainImage?.loadImage(withURL: imageURL, placeholderImage: nil)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = presenter.userData(forIndex: indexPath.row)
        let viewController = UserDetailViewController.initViewController(user: user)
        
        navigationController?.show(viewController, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UserViewCell.Constants.cellHeight
    }
}

extension UsersListViewControlller: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if isFiltering { return }
        
        let itemsCount = presenter.numberOfItems(isFiltering: false)
        if itemsCount > 1,
            let nextRow = indexPaths.last?.row,
            nextRow >= itemsCount - 1 {
            presenter.prefetchItems()
        }
    }
}

extension UsersListViewControlller: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.filterContentForSearchText(searchText)
    }
}
