//
//  Tools.swift
//  Celo
//
//  Created by Viajeros Lado B on 20/06/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import UIKit

struct Tools {
    struct Constants {
        static let smallDeviceWidth: CGFloat = 400
    }
    
    static let isSmallSizeDevice: Bool = UIScreen.main.bounds.width < Constants.smallDeviceWidth
}


