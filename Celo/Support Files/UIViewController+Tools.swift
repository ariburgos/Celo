//
//  UIViewController+Tools.swift
//  Celo
//
//  Created by Viajeros Lado B on 18/06/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(message: String, actionTitle: String? = nil) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle ?? "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
