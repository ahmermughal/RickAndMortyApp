//
//  UIImageView+Ext.swift
//  RickAndMortyApp
//
//  Created by Ahmer Akhter on 18/05/2023.
//

import UIKit


extension UIImageView{
    
    @discardableResult func setImageWithUrl(url:String, scale: CGFloat = 1.0) -> UIImageView? {
                
        let cacheKey = NSString(string: url)
        
        if let image = CacheManager.shared.imageCache.object(forKey: cacheKey){
            self.image = image
            return self
        }
        
        guard let url = URL(string: url) else {
            return self
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in

            if (data != nil && error == nil) {
                if let loadedImage = UIImage(data: data!) {
                    DispatchQueue.main.async {
                        self.image = loadedImage
                        CacheManager.shared.imageCache.setObject(loadedImage, forKey: cacheKey)
                    }
                }
            }
        }.resume()
        
        return self
    }
    
}
