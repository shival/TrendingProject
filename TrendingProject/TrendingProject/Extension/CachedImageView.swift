//
//  CachedImageView.swift
//  TrendingProject
//
//  Created by Shival Pandya on 8/21/18.
//  Copyright © 2018 Shival Pandya. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class CachedImageView: UIImageView {
    
    var imageURLString: String?
    
    func loadImageUsingURLString(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        imageURLString = urlString
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                self.image = UIImage(named: "profile-image")
                return
            }
            
            DispatchQueue.main.async {
                if let data = data, let imageToCache = UIImage(data: data) {
                    
                    if self.imageURLString == urlString {
                        self.image = imageToCache
                    }
                    imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                } else {
                    self.image = UIImage(named: "profile-image")
                }
            }
            
            }.resume()
    }
}
