//
//  Cache.swift
//  Image_Loading_Library
//
//  Created by Vishnu on 30/09/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import Foundation
import UIKit

class Cache : NSObject{
    
    lazy var memorylevelCache = MemoryCache()
    
    private static var instance : Cache?
    
    public static func sharedInstance() -> Cache{
        if instance == nil{
            instance = Cache()
        }
        return instance!
    }
    
    private override init() {
        super.init()
    }

    
    /*init(builder : Builder) {
        cacheAction(builder: builder)
    }*/
    
    func cacheAction(cacheType:CacheType, url:String, image:UIImage){

        switch cacheType {
        case .Memory:
            self.memorylevelCache.set(url: url, for: image)
        case .Disk:
            print("Cached in Disk")
        default:
            print("No Cache")
        }
        
    }
    
    /*public class Builder{
        
        fileprivate var type : CacheType?
        fileprivate var url : String?
        fileprivate var image : UIImage?
        
        func cacheType(type : CacheType) -> Builder{
            self.type = type
            return self
        }
        
        func cacheUrl(url:String) -> Builder {
            self.url = url
            return self
        }
        
        func cacheImage(image:UIImage) -> Builder {
            self.image = image
            return self
        }
        
        func build() -> Cache {
            return Cache(builder: self)
        }
    }*/
}
