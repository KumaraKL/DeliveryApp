//
//  LALResponseDataHandler.swift
//  Lalamove
//
//  Created by Kumar on 19/09/18.
//  Copyright © 2018 Kumar. All rights reserved.
//

import Foundation
import Alamofire


enum LALClientAPIResponseData {
    case error (Error) //TODO: Customise the Error based domain, reachability, Error description
    case somethingWentWrong (Int)
    case success (Data)
    
    init(response: DefaultDataResponse){
        if let _error = response.error{
            self = .error(_error)
        }else if response.response?.statusCode == 200{
            if let _responseData = response.data{
                self = .success(_responseData)
            }else{
                self = .somethingWentWrong(1)
            }
        }else{
            self = .somethingWentWrong(1)
        }
    }
}
