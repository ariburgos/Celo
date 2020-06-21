//
//  UserDetailPresenter.swift
//  Celo
//
//  Created by Viajeros Lado B on 18/06/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import Foundation

protocol UserDetailViewDelegate: NSObjectProtocol {
    func showUser(name: String, imageURL: URL?, gender: String, birthday: String, email: String, phone: String, cellphone: String, nationality: String, address: String, lat: String?, long: String?)
}

class UserDetailPresenter {
    weak private var view : UserDetailViewDelegate?
    var user: UserViewModel?
    
    func attachView(view: UserDetailViewDelegate?) {
        self.view = view
    }
    
    func setUser(user: UserViewModel?) {
        self.user = user
    }
    
    func loadUser() {
        guard let _ = user else { return }
        let completeName = user?.name?.toString() ?? ""
        
        var formatedBirthday: String = ""
        if let birthday = user?.dob?.date {
            formatedBirthday = DateFormatter.fullFormatStringToString(string: birthday, format: .prettyDate)
        }
        
        var imageURL: URL?
        if let thumbnailStringUrl = user?.picture?.large {
            imageURL = URL(string: thumbnailStringUrl)
        }
        
        let email = user?.email ?? ""
        let phone = user?.phone ?? ""
        let cellphone = user?.cell ?? ""
        let nationality = user?.nat ?? ""
        
        let address = user?.location?.toString() ?? ""

        let lat = user?.location?.coordinates?.latitude
        let long = user?.location?.coordinates?.longitude
        
        let gender = user?.gender ?? ""
        view?.showUser(name: completeName, imageURL: imageURL, gender: gender, birthday: formatedBirthday, email: email, phone: phone, cellphone: cellphone, nationality: nationality, address: address, lat: lat, long: long)
    }
}
