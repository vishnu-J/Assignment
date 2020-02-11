//
//  AssetManager.swift
//  Image_Loading_Library
//
//  Created by Vishnu on 27/09/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import Foundation
import UIKit


open class ImagePlacer : NSObject {
    
    private final let TAG = "Image_pla"
    
    lazy var memorylevelCache = MemoryCache()
    
    lazy var disklevelCache = DiskCache()
    
    private let downloadManager = DownloadManager()
    
    private let imageProcessor = ImageProcessor()
    
    open var cacheLevel : CacheType = .Memory
    
    open var enableDebugLog = false
    
    private static var instance : ImagePlacer?
    
    private override init() {
        super.init()
    }
    
    
    /// Singleton method will return the ImagePlacer instance
    public static func sharedInstance() -> ImagePlacer{
        if instance == nil{
            instance = ImagePlacer()
        }
        return instance!
    }
    
    /// To download the image from the url and render it over the give imageView Instance
    /// - Parameter url: to download image
    /// - Parameter imageView: imageview to set the downloaded/cached image.
    open func render(for url: String,mountOver imageView: UIImageView) {
        
        if url.isEmpty{
            Logger.i(tag: TAG, message: "Invalid URL")
            return
        }
        
        if self.cacheValidation(url: url, imageView: imageView){
            Logger.i(tag: TAG, message: "Image already cached in \(cacheLevel)")
            return
        }
        
        downloadManager.downloadAsset(urlString: url) { (success, imageData, error) in
            if success{
                DispatchQueue.main.async {
                self.imageProcessor.processImage(data: imageData!, url: url, imageHolder: imageView)
                }
            }else{

            }
        }
    }
    
    /// To download the image from the url and return the image
    /// - Parameter url: to download image
    /// - Parameter completion: closure to return the image or error
    open func render(for url:String, completion:@escaping(UIImage?, String?) -> ()){
        if url.isEmpty{
           Logger.i(tag: TAG, message: "Invalid URL")
           completion(nil, "Invalid URL")
        }
               
        if self.cacheValidation(url: url, imageView: nil){
           Logger.i(tag: TAG, message: "Image already cached")
            switch cacheLevel {
            case .Memory:
                let image = self.memorylevelCache.get(url: url)
                completion(image,nil)
            case .Disk:
                let image = self.disklevelCache.get(url: url)
                completion(image,nil)
            default:
                completion(nil,"UnKnown Cache level")
            }
        }
        
        downloadManager.downloadAsset(urlString: url) { (success, imageData, error) in
            if success{
                DispatchQueue.main.async {
                    guard let data = imageData else{
                        completion(nil,error)
                        return
                    }
                    let imageFromData = UIImage(data: data)
                    completion(imageFromData,nil)
                }
            }else{
                completion(nil,error)
            }
        }
    }
    
    /// cacheValidation wil validate whether the given url image is already cached or not
    /// - Parameter url: key to get the ccahed image
    /// - Parameter imageView: is optional ,if imageview is available will place the cached image over it
    private func cacheValidation(url:String, imageView:UIImageView?) -> Bool{
        switch self.cacheLevel {
        case .Memory:
            if memorylevelCache.isCached(url: url){
                if let image = self.memorylevelCache.get(url: url){
                    if let imageView = imageView{
                        imageView.image = image
                    }
                    return true
                }
                return false
            }
            
        case .Disk:
            
            if disklevelCache.isCached(url: url){
                if let image = self.disklevelCache.get(url: url){
                    DispatchQueue.main.async {
                        if let imageView = imageView{
                            imageView.image = image
                        }
                    }
                    return true
                }
                return false
            }
        default:break
        }
        return false
    }
}

