//
//  File.swift
//  Lalamove
//
//  Created by Kumar on 21/09/18.
//  Copyright © 2018 Kumar. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    func loadImageUsingCache(withUrl urlString : String, completionHandelr: @escaping (Bool) -> Void) {
        if let url = URL(string: urlString){
            // self.image = nil
            
            // check cached image
            if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
                self.image = cachedImage
                completionHandelr(true)
                return
            }
            
            
            Alamofire.request(url).responseImage { response in
                guard let image = response.result.value else {
                    completionHandelr(false)
                    return
                }
                // Do stuff with your image
                DispatchQueue.main.async {
                        imageCache.setObject(image,forKey: urlString as NSString)
                        self.image = image
                        completionHandelr(true)
                }
            }
        }

    }
    
    func roundedImage() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.borderWidth = 2.5
        self.layer.borderColor = LALColors.navTintColor.cgColor
    }
    
}


//MARK: STRING
extension String {
    func sliceByString(from:String) -> String? {
        let range = self.range(of: from)
        if let _range = range{
            return String(self[_range.upperBound...])
        }
        return nil
    }
    
    func sliceByString(from:String, to:String) -> String? {
        //From - startIndex
        var range = self.range(of: from)
        let subString = String(self[range!.upperBound...])
        
        //To - endIndex
        range = subString.range(of: to)
        return String(subString[..<range!.lowerBound])
    }
}
