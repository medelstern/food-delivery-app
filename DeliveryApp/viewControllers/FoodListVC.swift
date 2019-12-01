//
//  FoodListVC.swift
//  DeliveryApp
//
//  Created by kh on 8/14/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import UIKit

class FoodListVC: UIViewController, WormTabStripDelegate, ProductListVCDelegate {
    
    weak var productListVC: ProductListVC?
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var lblCart: UILabel!
    @IBOutlet weak var viewShowBtn: UIView!
    
    var tabs:[ProductListVC] = []
    var cartItems = [ProductItem]()
    
    public static var __shared : FoodListVC?
    
    var tabTitles: [String] = ["Pizza", "Combo", "Sides", "Veberage"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //        self.view.backgroundColor = UIColor(netHex: 0x364756)
        let logo = UIImage(named: "ic_logo")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        setUpTabs()
        setUpViewPager()
        FoodListVC.__shared = self
        
        for tab in tabs {
            tab.delegate = self
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(addCartItem(notification:)), name: Notification.Name("added_cart"), object: nil)
        
        setUpCartItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        setUpCartItems()
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func setUpCartItems() {
        cartItems = AppConstants.getCartItems()
        if cartItems.count > 0{
            viewShowBtn.isHidden =  false
        }
        var sum_price = Float(0.0)
        for item in cartItems {
            sum_price += item.getPrice()
        }
        let price_str = String(format: "%.2f", sum_price)
        lblCart.text = "\(cartItems.count) Item : \(price_str)$"
    }
    
    @IBAction func onSearch(_ sender: Any) {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Orderity", message: "", preferredStyle: .alert)
        
     
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Detail"
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { [weak alert] (_) in
            print("cerrar")
        }))
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak alert] (_) in
            
        }))
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    func setUpViewPager(){
        let frame =  CGRect(x: 0, y: 0, width: viewMain.frame.size.width, height: viewMain.frame.size.height)
        let viewPager:WormTabStrip = WormTabStrip(frame: frame)
        viewMain.addSubview(viewPager)
        viewPager.delegate = self
        viewPager.eyStyle.wormStyel = .LINE
        viewPager.eyStyle.isWormEnable = false
        viewPager.eyStyle.spacingBetweenTabs = 15
        viewPager.eyStyle.tabItemSelectedColor = UIColor.init(red: 0, green: 174, blue: 239)
        viewPager.currentTabIndex = 0
        viewPager.buildUI()
    }
//
    func setUpTabs(){
        for i in 1...tabTitles.count {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "productListVC") as! ProductListVC
            //            var rect = vc.view.frame
            //            rect.width = viewMain.bounds.width
            //            rect.height = viewMain.bounds.height
            //            vc.view.frame = rect
            tabs.append(vc)
        }
    }
//
    func WTSNumberOfTabs() -> Int {
        return tabTitles.count
    }

    func WTSViewOfTab(index: Int) -> UIView {
        let view = tabs[index]
        return view.view
    }

    func WTSTitleForTab(index: Int) -> String {
        return tabTitles[index]
    }

    func WTSReachedLeftEdge(panParam: UIPanGestureRecognizer) {

    }

    func WTSReachedRightEdge(panParam: UIPanGestureRecognizer) {

    }
    
    @objc func addCartItem(notification: NSNotification) {
        cartItems = AppConstants.getCartItems()
        var sum_price = Float(0.0)
        for item in cartItems {
            sum_price += item.getPrice()
        }
        let price_str = String(format: "%.2f", sum_price)
        lblCart.text = "\(cartItems.count) Item : \(price_str)$"
    }
    
    @IBAction func viewCartClicked(_ sender: Any) {
        if cartItems.count == 0 {
            showToast(message: "No items")
        } else {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.goToTabBarScreen(index: 3)
        }
    }
    
  
}
