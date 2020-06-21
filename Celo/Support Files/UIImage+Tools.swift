//
//  UIImage+Tools.swift
//  Celo
//
//  Created by Viajeros Lado B on 18/06/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import UIKit

var imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func loadImage(withURL url: URL,
                   placeholderImage: UIImage? = nil) {
        
        if let cacheImage = imageCache.object(forKey: url.lastPathComponent as AnyObject) as? UIImage {
            self.image = cacheImage
            return
        }
        
        HTTPConnector.shared.fetchData(url: url) { (data, error) in
            if let error = error {
                print("Couldn't download image: ", error)
                return
            }
            
            guard let data = data else {
                print("Data error")
                return
            }
            
            if let image = UIImage(data: data) {
                imageCache.setObject(image, forKey: url.lastPathComponent as AnyObject)
                
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }    
}
