//
//  DownloadManager.swift
//  Image_Loading_Library
//
//  Created by Vishnu on 28/09/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import Foundation

class DownloadManager  {
    
    final let TAG = "Dow_magr"
    
    init() {}
    
     func downloadAsset(urlString: String, completion: @escaping (Bool, Data?, String?) -> ()) {
        
        Logger.d(tag: TAG, message: "Download Manager Called")
        
        if urlString.isEmpty{
            Logger.i(tag: TAG, message: Constant.INVALID_URL)
            return
        }
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                guard data != nil , response != nil, error == nil else {
                    Logger.i(tag: self.TAG, message: "Download Failed for url : \(urlString)")
                    completion(false,nil, error?.localizedDescription)
                    return
                }
                
                Logger.i(tag: self.TAG, message: "Downloaded the Image successfully for the url : \(urlString)")
                
                completion(true,data!, nil)
            }.resume()
        } else {
            Logger.d(tag: self.TAG, message: "Not able to produce the URL")
        }
    }
}
