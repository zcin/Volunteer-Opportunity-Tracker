//
//  Extensions.swift
//  Volunteer Opportunity Tracker
//
//  Created by Cindy Zhang on 3/14/18.
//  Copyright © 2018 Cindy Zhang. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadImageUsingCacheWithURLString (urlString: String) {
        
        // check cache for image first
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        
        // otherwise fire off a new download
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data, error == nil else { return }
            
            
            
            print("Download Finished", response?.suggestedFilename ?? url!.lastPathComponent)
            if (error != nil) {
                print(error!)
                return
            }
            
            DispatchQueue.main.async() {
                if let downloadedImage = UIImage(data: data) {
                    imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                    self.image = downloadedImage
                }
            }
            
        }.resume()
    }
}
