//
//  Rounderswift
//  Celo
//
//  Created by Viajeros Lado B on 18/06/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import UIKit

@IBDesignable
class RounderImageView: UIImageView {
    @IBInspectable
    var isRounder: Bool = false {
        didSet {
            self.layer.borderWidth = 1
            self.layer.masksToBounds = false
            self.layer.borderColor = UIColor.clear.cgColor
            self.layer.cornerRadius = self.frame.height / 2
            self.clipsToBounds = true
        }
    }
}
