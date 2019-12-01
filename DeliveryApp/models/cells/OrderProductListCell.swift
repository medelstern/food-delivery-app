//
//  OrderProductListCell.swift
//  DeliveryApp
//
//  Created by Star on 10/13/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import UIKit

class OrderProductListCell: UITableViewCell {

    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtFeature: UILabel!
    @IBOutlet weak var txtDescription: UILabel!
    @IBOutlet weak var txtPrice: UILabel!
    @IBOutlet weak var txtCount: UILabel!
    @IBOutlet weak var btnIncrease: UIButton!
    @IBOutlet weak var btnDecrease: UIButton!
    
    public func setOrderProductData(data: OrderedProductItem) {
        
        txtTitle.text = data.getTitle()
        txtFeature.text = data.getFeature()
        txtDescription.text = data.getDescription()
        txtPrice.text = "$\(data.getPrice())"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
