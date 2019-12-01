//
//  ProductItem.swift
//  DeliveryApp
//
//  Created by jonh on 8/12/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import Foundation

class ProductItem {
    private var isOneType: Bool!
    private var productName: String!
    private var description: String!
    private var price: Float!
    private var count: Int
    
    init(name: String, desc: String, price: Float, oneType: Bool, count: Int) {
        self.isOneType = oneType
        self.productName = name
        self.description = desc
        self.price = price
        self.count = count
    }
    
    init(_ json: [String: Any]) {
        price = Float("\(json["price"]!)")
        isOneType = (json["oneType"] as? Bool)!
        productName  = (json["name"] as? String)!
        description = (json["desc"] as? String)!
        count = (json["count"] as? Int)!
    }
    
    func toDictionary() -> [String: Any] {
        var dict = [String: Any]()
        dict["price"] = price
        dict["oneType"] = isOneType
        dict["name"] = productName
        dict["desc"] = description
        dict["count"] = count
        return dict
    }
    
    public func getProductName() -> String {
        return self.productName
    }
    
    public func getDescription() -> String {
        return self.description
    }
    
    public func oneType() -> Bool {
        return self.isOneType
    }
    
    public func getPrice() -> Float {
        return self.price
    }
    
    public func setPrice(price: Float) {
        self.price = price
    }
    
    public func getCount() -> Int {
        return self.count
    }
    
    public func setCount(count: Int) {
        self.count = count
    }
    
}
