//
//  InitAPI.swift
//  thewhiteknight
//
//  Created by apple on 7/13/18.
//  Copyright © 2018 greedygame. All rights reserved.
//


import Foundation

public enum API {
    case dev
}

extension API: EndPointType {
    
    private static let TAG = "GGamApi"
    
    var environmentBaseURL : String {
        switch NetworkBase.environment {
        case .production:
            return "https://38rhabtq01.execute-api.ap-south-1.amazonaws.com/dev/schedule"
        case .qa:
            return "https://38rhabtq01.execute-api.ap-south-1.amazonaws.com/dev/schedule"
        case .staging:
            return  "https://38rhabtq01.execute-api.ap-south-1.amazonaws.com/dev/schedule"
        }
    }
    
    var baseURL: URL? {
        switch self {
        case .dev:
            guard let url = URL(string: environmentBaseURL) else {
                return nil
            }
            return url
        }

    }
    
    var path: String {
        switch self {
        case .dev:
            return ""
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case.dev:
            return .get
        default:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .dev :
                return .requestParameters(bodyParameters: nil,bodyEncoding: .urlEncoding,
                                            urlParameters: nil)
        default:
            return .requestDefault
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .dev:
            return [:]
        default:
            return [:]
        }
    }
    
}
