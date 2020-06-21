//
//  LoadingView.swift
//  Celo
//
//  Created by Viajeros Lado B on 20/06/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import UIKit

public class LoadingView {
    public static let shared = LoadingView()
    var blurImage = UIImageView()
    var indicator = UIActivityIndicatorView()

    private init()
    {
        blurImage.frame = UIScreen.main.bounds
        blurImage.backgroundColor = UIColor.lightGray
        blurImage.isUserInteractionEnabled = true
        blurImage.alpha = 0.3
        indicator.style = .whiteLarge
        indicator.center = blurImage.center
        indicator.startAnimating()
        indicator.color = .blue
    }

    func showIndicator(){
        DispatchQueue.main.async(execute: {
            UIApplication.shared.keyWindow?.addSubview(self.blurImage)
            UIApplication.shared.keyWindow?.addSubview(self.indicator)
        })
    }
    
    func hideIndicator(){
        DispatchQueue.main.async(execute: {
                self.blurImage.removeFromSuperview()
                self.indicator.removeFromSuperview()
        })
    }
}
