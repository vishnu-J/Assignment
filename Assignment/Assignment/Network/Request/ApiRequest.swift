//
//  ApiRequest.swift
//  Assignment
//
//  Created by Vishnu on 10/02/20.
//  Copyright © 2020 Vishnu. All rights reserved.
//

import Foundation

class ApiRequest: APINetworkBase, NetworkProtocol {
    
    typealias NetworkReturnType = MediTasks
    
    private static let TAG = "APIReq"
    
    func makeRequest(completion: @escaping (MediTasks?, String?) -> ()) {
        self.router.request(.dev) { (data, response, error) in
            if error != nil {
                Logger.d(tag: ApiRequest.TAG, message: "API request failed with error \(error?.localizedDescription ?? "UnknownError")")
            completion(nil, "API request failed with error \(error?.localizedDescription ?? "UnknownError")")
                  return
            }
  
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)

                switch result {
                case .success:
                  guard let responseData = data else {
                      completion(nil, NetworkResponse.noData.rawValue)
                      return
                  }
                  do {
                      _ = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                      let apiResponse = try JSONDecoder().decode(MediTasks.self, from: responseData)
                      
                      completion(apiResponse,nil)
                  }catch {
                      completion(nil, NetworkResponse.unableToDecode.rawValue)
                  }
                  
                case .failure(let networkFailureError):
                  completion(nil, networkFailureError)
                }
            }
        }
    }
}
