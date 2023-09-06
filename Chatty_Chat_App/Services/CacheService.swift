//
//  CacheService.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 9/5/23.
//

import Foundation
import SwiftUI


class CacheService {
    
    //Stores image components with URL string as key
    private static var imageCache = [String: Image]()
    
    ///Return image for given key. If nil, no image exists
    static func getImage(forKey: String) -> Image? {
        
        return imageCache[forKey]

    }
    
    ///Stores image component in cache with given key
   static func setImage(image: Image, forKey: String) {
        imageCache[forKey] = image
    }
    
}
