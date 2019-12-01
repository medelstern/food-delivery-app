//
//  OrderedProductItem.swift
//  DeliveryApp
//
//  Created by kh on 8/13/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import Foundation

class OrderedProductItem {
    private var productImage: String!
    private var productTitle: String!
    private var productFeature: String!
    private var productDescription: String!
    private var productPrice: Float!
    private var count: Int!
    
    init(image: String, title: String, feature: String, desc: String, price: Float, count: Int) {
        self.productImage = image
        self.productTitle = title
        self.productFeature = feature
        self.productDescription = desc
        self.productPrice = price
        self.count = count
    }
    
    public func getImage() -> String {
        return self.productImage
    }
    
    public func getTitle() -> String {
        return self.productTitle
    }
    
    public func getFeature() -> String {
        return self.productFeature
    }
    
    public func getDescription() -> String {
        return self.productDescription
    }
    
    public func getPrice() -> Float {
        return self.productPrice
    }
    
    public func getCount() -> Int {
        return self.count
    }
    
    
}
