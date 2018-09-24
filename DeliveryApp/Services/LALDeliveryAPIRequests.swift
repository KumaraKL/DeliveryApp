//
//  LELDeliveryAPIRequests.swift
//  Lalamove
//
//  Created by Kumar on 19/09/18.
//  Copyright © 2018 Kumar. All rights reserved.
//

import UIKit
import Alamofire



//enum LALDeliveryAPIRequests: LALNetworkingRequestBuilder {
//    case deliveryItems
//
//}


class LALDeliveryAPIRequests: LALNetworkingRequestBuilder {
    var manager = Alamofire.SessionManager.default
    
    init() {
        manager.session.configuration.timeoutIntervalForRequest = 60
    }
    
    func requestDeliveryItems(offset:Int, range:Int, completion: @escaping (LALClientAPIResponseData)-> Void){
        let urlString = "\(kHostName)/deliveries"
        let urlParametersString = "\(urlString)?offset=\(offset)&limit=\(range)"//["offset": offset, "limit": range]
        
        manager.request(urlParametersString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .response { (response) in
                completion(LALClientAPIResponseData.init(response: response))
        }
    }
}
