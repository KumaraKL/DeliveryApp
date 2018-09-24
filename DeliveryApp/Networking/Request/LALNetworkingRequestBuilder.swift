
//
//  LALNetworkingRequestBuilder.swift
//  Lalamove
//
//  Created by Kumar on 19/09/18.
//  Copyright © 2018 Kumar. All rights reserved.
//

import Foundation
let kHostName = "https://mock-api-mobile.dev.lalamove.com"


protocol LALNetworkingRequestBuilder {
    var baseURL: URL { get }
    var headers: [String:String] {get}
    // var requestURL: URL { get }
    //    var parameters: Parameters? { get }
    //   var method: HTTPMethod { get }
    //   var encoding: ParameterEncoding { get }
    //    var urlRequest: URLRequest { get }
}


extension LALNetworkingRequestBuilder{
    var baseURL: URL{
        return  URL(string: kHostName)!
    }
    
    var headers : [String:String]{
        return ["Content-Type": "application/json"]
    }
}
