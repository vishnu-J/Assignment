//
//  DiskCache.swift
//  Image_Loading_Library
//
//  Created by Vishnu on 30/09/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import Foundation
import UIKit

class DiskCache : CacheProtocol  {
    
    static let TAG = "DiskChe"
    
    private var resolvedPath : String?
    
    private var cachedUrlpathDict = [String:String]()
    
    public typealias SingleDownloadCompletion = (_ success: Bool, _ error: String?)->()

    init() {
        self.resolvedPath = FileUtils.imagePlacerPath?.path
    }
    
    /// To cache the image in local storage
    /// - Parameter url: url is served as a key to store the image
    /// - Parameter image: to be cached
    func set(url: String, for image: UIImage) {
        if url.isEmpty{
           Logger.d(tag: DiskCache.TAG, message: "Inavlid URL")
           return
        }
                
        guard let pathURL = FileUtils.imagePlacerPath?.appendingPathComponent("\(StringUtils.md5(url)).png") else{
            return
        }
        
        if FileUtils.saveUIImageToPath(image: image, pathurl: pathURL){
            cachedUrlpathDict[url] = pathURL.absoluteString
        }
    }
    
    /// To get the cached Image
    /// - Parameter url: url  to get the cached image from local storage
    func get(url: String) -> UIImage? {
        if url.isEmpty{
           Logger.d(tag: DiskCache.TAG, message: "Inavlid URL")
           return nil
        }
        
        guard let pathURL = FileUtils.imagePlacerPath?.appendingPathComponent("\(StringUtils.md5(url)).png") else{
                 return nil
        }
        
//        let pathURL = cachedUrlpathDict[url]
                        
        guard let fileData = FileUtils.readFile(url: pathURL.path) else {
            return nil
        }
        return UIImage(data: fileData)
    }
    
    /// evict to remove the particular cached image of the url
    /// - Parameter url: url to map the image in local storage.
    func evict(url: String) {
        if url.isEmpty{
            Logger.d(tag: DiskCache.TAG, message: "Inavlid URL")
            return
        }
        
        guard let pathURL = cachedUrlpathDict[url] else{
            Logger.d(tag: DiskCache.TAG, message: "Path not available to evict the image")
            return
        }
        
        if FileUtils.delete(url: URL(fileURLWithPath: pathURL)){
            Logger.d(tag: DiskCache.TAG, message: "Image evicted successfully")
            cachedUrlpathDict.removeValue(forKey: url)
        }else{
            Logger.d(tag: DiskCache.TAG, message: "Failed to evict the Image")
        }
    }
    
    /// To remove all the cache image
    func clearCache() {
        var count = 0
        
        cachedUrlpathDict.forEach { (key,value) in
            evict(url: key)
        }
        
        for value in cachedUrlpathDict.values{
            if FileUtils.delete(url: URL(fileURLWithPath: value)){
                Logger.d(tag: DiskCache.TAG, message: "Image evicted successfully")
                count += 1
            }else{
                Logger.d(tag: DiskCache.TAG, message: "Failed to evict the Image")
            }
        }
        
        if cachedUrlpathDict.count == count{
            cachedUrlpathDict.removeAll()
        }else{
            Logger.d(tag: DiskCache.TAG, message: "clearCache is not completed")
        }
    }
    
    /// To get the cached image count
    func count() -> Int {
        return cachedUrlpathDict.count
    }
    
    /// To verify whether the image is already cached or not
    /// - Parameter url: url to verify
    func isCached(url:String) -> Bool {
//        if cachedUrlpathDict.isEmpty{
//            return false
//        }
        
        guard let pathURL = FileUtils.imagePlacerPath?.appendingPathComponent("\(StringUtils.md5(url)).png") else{
            return false
        }
        
//        if let path = cachedUrlpathDict[url]{
        if (FileUtils.readFile(url: pathURL.path) != nil){
                return true
        }else{
                return false
        }
//        }
        
        return false
    }
}
