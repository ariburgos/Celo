//
//  UserViewCell.swift
//  Celo
//
//  Created by Viajeros Lado B on 18/06/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import Foundation
import UIKit

class UserViewCell: UITableViewCell {
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderTitleLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var dateOfbirthTitleLabel: UILabel!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    
    @IBOutlet weak var middleSeparatorView: UIView!
    @IBOutlet weak var bottonSeparatorView: UIView!
 
    enum Constants {
        static let cellHeight: CGFloat = 114
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if Tools.isSmallSizeDevice {
            genderLabel.font = UIFont.systemFont(ofSize: 10)
            dateOfBirthLabel.font = UIFont.systemFont(ofSize: 10)
            genderTitleLabel.font = UIFont.systemFont(ofSize: 10)
            dateOfbirthTitleLabel.font = UIFont.systemFont(ofSize: 10)
        }
    }
    
}
