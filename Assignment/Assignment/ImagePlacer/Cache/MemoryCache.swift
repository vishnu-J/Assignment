//
//  Cache.swift
//  Image_Loading_Library
//
//  Created by Vishnu on 28/09/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import Foundation
import UIKit

class MemoryCache : CacheProtocol {

    final let TAG = "Mem_Cache"
 
    private var cacheDictionary = [String:UIImage]()
    
    init() {}
    
    /// To cache the image in cacheDictionary
    /// - Parameter url: url is served as a key to store the image
    /// - Parameter image: to be cached
    func set(url: String, for image:UIImage) {
        if url.isEmpty{
            Logger.d(tag: TAG , message: "Cache failed")
            return
        }
        self.cacheDictionary[url] = image
        Logger.d(tag: TAG , message: "Cached successfully")
    }
    
    
    /// To get the cached Image
    /// - Parameter url: url is served as the key to get the image cached in cacheDictionary
    func get(url: String) -> UIImage?{
        if url.isEmpty{
            Logger.d(tag: TAG, message: "Fetching Cached image failed")
            return nil
        }
        
        guard let image = cacheDictionary[url] else { return nil }
        return image
    }
    
    /// evict to remove the particular cached image of the url
    /// - Parameter url: url is served as a key to map the image in cacheDictionary.
    func evict(url: String) {
        if url.isEmpty{
            Logger.d(tag: DiskCache.TAG, message: "Inavlid URL")
            return
        }
        self.cacheDictionary.removeValue(forKey: url)
    }
    
    /// To empty the cacheDictionary
    func clearCache() {
        if !cacheDictionary.isEmpty{
            self.cacheDictionary.removeAll()
        }
    }
    
    
    /// To get the cached image count
    func count() -> Int {
        return cacheDictionary.count
    }
    
    
    /// To verify whether the image is already cached or not
    /// - Parameter url: url to verify
    func isCached(url: String) -> Bool {
        if cacheDictionary.isEmpty{
            return false
        }
        
        if let _ = cacheDictionary[url]{
            return true
        }
        return false
    }
}
