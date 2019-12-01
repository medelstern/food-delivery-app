//
//  ProductListVC.swift
//  DeliveryApp
//
//  Created by kh on 8/12/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import UIKit

class ProductListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    weak var delegate: ProductListVCDelegate?
   
    @IBOutlet weak var tableView: UITableView!
    var selectedProduct: ProductItem!
    var productList: [ProductItem] = []
    var cartItems = [ProductItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedProduct = ProductItem(name: "FARM HOUSE", desc: "A pizza that goes ballistic on veggies! Check out this mouth watering overload of crunchy, crisp capsicum, succulent, etc.ballistic on veggies! Check out this mouth watering overload of ", price: 5.99, oneType: true, count: 1)
        // Do any additional setup after loading the view.
        tableView.backgroundColor = UIColor.clear
        loadData()
    }
    
    @objc func viewItem(sender: UIButton!) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "orderPlacingVC")
        FoodListVC.__shared?.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @objc func addToCart(sender: UIButton!) {
        cartItems = AppConstants.getCartItems()
        cartItems.append(selectedProduct)
        var jsonDict = [[String: Any]]()
        for child in cartItems {
            jsonDict.append(child.toDictionary())
        }
        LocalStorage[SAVED_CARTS] = jsonDict
        delegate?.setUpCartItems()
    }
    
    @objc func deleteFromFavorites(sender: UIButton!) {
        productList.remove(at: sender.tag)
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favouriteTableCell", for: indexPath) as! FavouriteListCell
        cell.setItemData(data: productList[indexPath.row])
        cell.selectionStyle = .none
        cell.btnAddToCart.tag = indexPath.row
        
        if indexPath.row == 1 {
            cell.btnAddToCart.setTitle("ADD TO CART", for: .normal)
            cell.btnAddToCart.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        } else {
            cell.btnAddToCart.backgroundColor = UIColor(netHex: 0xB3B3B3)
            cell.btnAddToCart.setTitle("VIEW ITEM", for: .normal)
            cell.btnAddToCart.addTarget(self, action: #selector(viewItem), for: .touchUpInside)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let data = productList[indexPath.row]
        if(data.oneType()) {
            return 230 - 40
        } else {
            return 230 - 40
        }
    }
    
    func loadData() {
        productList.append(ProductItem(name: "FARM HOUSE", desc: "A pizza that goes ballistic on veggies! Check out this mouth watering overload of crunchy, crisp capsicum, succulent, etc.ballistic on veggies! Check out this mouth watering overload of ", price: 5.99, oneType: true, count: 1))
        productList.append(ProductItem(name: "FARM HOUSE", desc: "A pizza that goes ballistic on veggies! Check out this mouth watering overload of crunchy, crisp capsicum, succulent, etc. ballistic on veggies! Check out this mouth watering overload of", price: 5.99, oneType: false, count : 1))
        self.tableView.reloadData()
    }
}

protocol ProductListVCDelegate: class {
    func setUpCartItems()
}
