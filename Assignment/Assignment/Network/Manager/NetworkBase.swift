//
//  NetworkManager.swift
//  NetworkLayer
//
//  Created by Malcolm Kumwenda on 2018/03/11.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

protocol NetworkProtocol {
    
    associatedtype NetworkReturnType
    
    func makeRequest(completion: @escaping (_ responseData: NetworkReturnType?,_ error: String?)->())
}

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String>{
    case success
    case failure(String)
}

enum NetworkEnvironment {
    case qa
    case production
    case staging
}

protocol RouterProtocol {
    associatedtype SelectedAPI : EndPointType
    var router: NetworkConfig<SelectedAPI>  { get }
}

public class NetworkBase {
    
    static let environment : NetworkEnvironment = .production
    
    internal func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}

public class APINetworkBase : NetworkBase, RouterProtocol {
    typealias SelectedAPI = API
    let router : NetworkConfig<API> = NetworkConfig<API>()
}



