//
//  OrderPlacingVC.swift
//  DeliveryApp
//
//  Created by kh on 8/14/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import UIKit

class OrderPlacingVC: UIViewController {

    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblSelectSize: UILabel!
    @IBOutlet weak var barSelectSize: UIView!
    @IBOutlet weak var lblSelectCrust: UILabel!
    @IBOutlet weak var barSelectCrust: UIView!
    @IBOutlet weak var lblSelectTopics: UILabel!
    @IBOutlet weak var barSelectTopics: UIView!
    
    @IBOutlet weak var largePriceView: UIView!
    @IBOutlet weak var mediumPriceView: UIView!
    @IBOutlet weak var smallPriceView: UIView!
    @IBOutlet weak var lblMedium: UILabel!
    @IBOutlet weak var lblMediumPrice: UILabel!
    @IBOutlet weak var lblLarge: UILabel!
    @IBOutlet weak var lblLargePrice: UILabel!
    @IBOutlet weak var lblSmall: UILabel!
    @IBOutlet weak var lblSmallPrice: UILabel!
    @IBOutlet weak var lblCart: UILabel!
    
    var count = 1
    var price = 5.99
    var select_type = 0
    var select_price = 1
    var selectedProduct: ProductItem!
    var cartItems = [ProductItem]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = true
        
        lblCount.text = "\(count)"
        lblPrice.text = String(format: "$%.2f", 5.99*Float(count))
        
        selectedProduct = ProductItem(name: "FARM HOUSE", desc: "A pizza that goes ballistic on veggies! Check out this mouth watering overload of crunchy, crisp capsicum, succulent, etc.ballistic on veggies! Check out this mouth watering overload of ", price: 5.99, oneType: true, count: 1)
        
        updateSelctViews()
        updateSelectPriceViews()
        setUpCartItems()
    }
    
    private func setUpCartItems() {
        cartItems = AppConstants.getCartItems()
        var sum_price = Float(0.0)
        for item in cartItems {
            sum_price += item.getPrice()
        }
        let price_str = String(format: "%.2f", sum_price)
        lblCart.text = "\(cartItems.count) Item : \(price_str)$"
    }

    @IBAction func onBack(_ sender: Any) {
        self.navigationController?.navigationBar.isHidden = false
    self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectSizePressed(_ sender: Any) {
        select_type = 0
        updateSelctViews()
    }
    
    @IBAction func selectCrustPressed(_ sender: Any) {
        select_type = 1
        updateSelctViews()
    }
    
    @IBAction func selectTopicsPressed(_ sender: Any) {
        select_type = 2
        updateSelctViews()
    }
    
    @IBAction func increasePressed(_ sender: Any) {
        count += 1
        selectedProduct.setCount(count: count)
        lblCount.text = "\(count)"
        lblPrice.text = String(format: "$%.2f", 5.99*Float(count))
    }
    
    @IBAction func decreasePressed(_ sender: Any) {
        if count > 1 {
            count -= 1
            selectedProduct.setCount(count: count)
            lblCount.text = "\(count)"
            lblPrice.text = String(format: "$%.2f", Float(price)*Float(count))
        }
    }
    
    @IBAction func mediumPricePressed(_ sender: Any) {
        select_price = 1
        updateSelectPriceViews()
        price = 5.99
        selectedProduct.setPrice(price: Float(price))
        lblPrice.text = String(format: "$%.2f", Float(price)*Float(count))
    }
    
    @IBAction func largePricePressed(_ sender: Any) {
        select_price = 2
        updateSelectPriceViews()
        price = 7.99
        selectedProduct.setPrice(price: Float(price))
        lblPrice.text = String(format: "$%.2f", Float(price)*Float(count))
    }
    
    @IBAction func smallPricePressed(_ sender: Any) {
        select_price = 0
        updateSelectPriceViews()
        price = 4.99
        selectedProduct.setPrice(price: Float(price))
        lblPrice.text = String(format: "$%.2f", Float(price)*Float(count))
    }
    
    @IBAction func addToCartPressed(_ sender: Any) {
        var cartItems = AppConstants.getCartItems()
        for _ in 1...count {
            cartItems.append(selectedProduct)
        }
        var jsonDict = [[String: Any]]()
        for child in cartItems {
            jsonDict.append(child.toDictionary())
        }
        
        LocalStorage[SAVED_CARTS] = jsonDict

        var sum_price = Float(0.0)
        for item in cartItems {
            sum_price += item.getPrice()
        }
        let price_str = String(format: "%.2f", sum_price)
        lblCart.text = "\(cartItems.count) Item : \(price_str)$"
    }
    
    @IBAction func viewCartClicked(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.goToTabBarScreen(index: 3)
    }
    
    
    private func updateSelctViews() {
        switch select_type {
        case 0:
            lblSelectSize.textColor = UIColor.init(red: 0, green: 174, blue: 239)
            lblSelectCrust.textColor = UIColor.black
            lblSelectTopics.textColor = UIColor.black
            lblSelectSize.font = UIFont.boldSystemFont(ofSize: 16.0)
            lblSelectCrust.font = UIFont.systemFont(ofSize: 16.0)
            lblSelectTopics.font = UIFont.systemFont(ofSize: 16.0)
            barSelectSize.isHidden = false
            barSelectCrust.isHidden = true
            barSelectTopics.isHidden = true
            break
        case 1:
            lblSelectSize.textColor = UIColor.black
            lblSelectCrust.textColor = UIColor.init(red: 0, green: 174, blue: 239)
            lblSelectTopics.textColor = UIColor.black
            lblSelectSize.font = UIFont.systemFont(ofSize: 16.0)
            lblSelectCrust.font = UIFont.boldSystemFont(ofSize: 16.0)
            lblSelectTopics.font = UIFont.systemFont(ofSize: 16.0)
            barSelectSize.isHidden = true
            barSelectCrust.isHidden = false
            barSelectTopics.isHidden = true
            break
        case 2:
            lblSelectSize.textColor = UIColor.black
            lblSelectCrust.textColor = UIColor.black
            lblSelectTopics.textColor = UIColor.init(red: 0, green: 174, blue: 239)
            lblSelectSize.font = UIFont.systemFont(ofSize: 16.0)
            lblSelectCrust.font = UIFont.systemFont(ofSize: 16.0)
            lblSelectTopics.font = UIFont.boldSystemFont(ofSize: 16.0)
            barSelectSize.isHidden = true
            barSelectCrust.isHidden = true
            barSelectTopics.isHidden = false
            break
        default:
            break
        }
    }
    
    private func updateSelectPriceViews() {
        switch select_price {
        case 0:
            smallPriceView.backgroundColor = UIColor.init(red: 0, green: 174, blue: 239)
            mediumPriceView.backgroundColor = UIColor.white
            largePriceView.backgroundColor = UIColor.white
            lblSmall.textColor = UIColor.white
            lblMedium.textColor = UIColor.black
            lblLarge.textColor = UIColor.black
            lblSmallPrice.textColor = UIColor.white
            lblMediumPrice.textColor = UIColor.init(red: 38, green: 181, blue: 15)
            lblLargePrice.textColor = UIColor.init(red: 38, green: 181, blue: 15)
            break
        case 1:
            smallPriceView.backgroundColor = UIColor.white
            mediumPriceView.backgroundColor = UIColor.init(red: 0, green: 174, blue: 239)
            largePriceView.backgroundColor = UIColor.white
            lblSmall.textColor = UIColor.black
            lblMedium.textColor = UIColor.white
            lblLarge.textColor = UIColor.black
            lblSmallPrice.textColor = UIColor.init(red: 38, green: 181, blue: 15)
            lblMediumPrice.textColor = UIColor.white
            lblLargePrice.textColor = UIColor.init(red: 38, green: 181, blue: 15)
            break
        case 2:
            smallPriceView.backgroundColor = UIColor.white
            mediumPriceView.backgroundColor = UIColor.white
            largePriceView.backgroundColor = UIColor.init(red: 0, green: 174, blue: 239)
            lblSmall.textColor = UIColor.black
            lblMedium.textColor = UIColor.black
            lblLarge.textColor = UIColor.white
            lblSmallPrice.textColor = UIColor.init(red: 38, green: 181, blue: 15)
            lblMediumPrice.textColor = UIColor.init(red: 38, green: 181, blue: 15)
            lblLargePrice.textColor = UIColor.white
            break
        default:
            break
        }
    }
}
