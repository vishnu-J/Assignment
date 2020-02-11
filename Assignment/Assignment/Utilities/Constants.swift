//
//  Constants.swift
//  Assignment
//
//  Created by Vishnu on 10/02/20.
//  Copyright © 2020 Vishnu. All rights reserved.
//

import Foundation

class Constant {
    static let SUPPLEMENT = "SUPP"
    static let VOD = "VOD"
    static let INVALID_URL = "invalid url"
    
    static var VideoUrl = ""
    
    static func isInternetAvailable() -> Bool{
        do {
            let connection = try Reachability().connection
            if connection != .unavailable{
                return true
            }else{
                return false
            }
        }catch{
            return false
        }
    }

}
