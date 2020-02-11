//
//  CacheProtocol.swift
//  Image_Loading_Library
//
//  Created by Vishnu on 28/09/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import Foundation
import UIKit

@objc protocol CacheProtocol {
    
    func set(url:String,for image:UIImage)
    func get(url:String) -> UIImage?
    func evict(url:String)
    func clearCache()
    func count() -> Int
    func isCached(url:String) -> Bool
    
}
