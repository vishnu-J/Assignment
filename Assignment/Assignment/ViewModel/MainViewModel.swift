//
//  MainViewModel.swift
//  Assignment
//
//  Created by Vishnu on 10/02/20.
//  Copyright © 2020 Vishnu. All rights reserved.
//

import Foundation

class MainViewModel : NSObject{
    
    func getData(completionHandler: @escaping (MediTasks?, String?) -> ()){
        let req = ApiRequest()
        req.makeRequest {[weak self] (mediTask, error) in
            completionHandler(mediTask,error)
        }
    }
    
}
