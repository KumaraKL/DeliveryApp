//
//  LALDeliveryListsModelController.swift
//  Lalamove
//
//  Created by Kumar on 19/09/18.
//  Copyright © 2018 Kumar. All rights reserved.
//

import UIKit

//MARK: LALDeliveryListsModel
typealias DeliveryLists = [DeliveryDetails]

struct Location: Decodable {
    let lat, lng: Double
    let address: String
}

class DeliveryDetails: Decodable {
    let id: Int
    let description: String
    let imageURL: String
    let location: Location
    
    enum CodingKeys: String, CodingKey {
        case id, description
        case imageURL = "imageUrl"
        case location
    }
}


extension DeliveryDetails{
    var name: String? {
        return self.description.sliceByString(from: " to ")
    }
    
    var deliveryType: String?{
        return self.description.sliceByString(from: "Deliver ", to: " to")
    }
}


//MARK:- LALDeliveryListsModelController

protocol DeliveryListsResponseDelegate: class {
    func deliveryItemsLoaded(isFirstFetch:Bool, range: NSRange)
    func error(_ errror: String)
}


class LALDeliveryListsModelController: NSObject {
    
    private let pageSize = 20
    private var currrentPage = 0
    
    weak var delgeate: DeliveryListsResponseDelegate?
    
    private var deliveryListItems = [DeliveryDetails]()
    private var loadMore = true
    
    func getDeliveryitem(atIndex index: Int) -> DeliveryDetails {
        // if deliveryListItems.indices.contains(index){
        return deliveryListItems[index]
        // }
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows() -> Int {
        return deliveryListItems.count
    }
    
    func canLoadMore() -> Bool {
        return loadMore
    }
}

extension LALDeliveryListsModelController{
    var deliveryAPI: LALDeliveryAPIRequests {
        return LALDeliveryAPIRequests()
    }
    
    func fetchDeliveryListItems(isFirstFetch: Bool)  {
        
        var offset = 0
        if isFirstFetch {// Pull to Refresh, For time being get the latest items of PAGESIZE
            loadMore = true
            self.currrentPage = 0
            offset = 0
        }else{
            offset = self.currrentPage + 1
        }
        
        deliveryAPI.requestDeliveryItems(offset: offset, range: pageSize) {[weak self] (responseData) in
            switch responseData{
            case .error(let error):
                self?.delgeate?.error(error.localizedDescription)
            case .success(let data):
                let items = try? JSONDecoder().decode(DeliveryLists.self, from: data)
                if let listItems = items{
                    print("items \(listItems)")
                    self?.currrentPage += listItems.count
                   
                    if isFirstFetch{
                        //TODO: Check for latest items and concatinate to <deliveryListItems> based on comparing woth existing <DeliveryDetails.id>
                        self?.deliveryListItems.removeAll()
                    }
                    
                    self?.deliveryListItems.append(contentsOf: listItems)
                    if (listItems.count < (self?.pageSize)!){
                        self?.loadMore = false
                    }
                    self?.delgeate?.deliveryItemsLoaded(isFirstFetch: isFirstFetch, range: NSMakeRange(offset, listItems.count))
                }
            case .somethingWentWrong(_):
                self?.delgeate?.error("Something Went Wrong, Please try again")
            }
        }
    }
    
}

