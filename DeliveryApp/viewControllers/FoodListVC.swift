//
//  FoodListVC.swift
//  DeliveryApp
//
//  Created by kh on 8/14/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import UIKit


class FoodListVC: UIViewController, WormTabStripDelegate, ProductListVCDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var searchTextField: UIBarButtonItem!
    weak var productListVC: ProductListVC?
    var viewPager: WormTabStrip?
    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var lblCart: UILabel!
    @IBOutlet weak var viewShowBtn: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchImage: UIImageView!
    @IBOutlet weak var searchBorder: UILabel!
    @IBOutlet weak var searchTextF: UITextField!
    
    var tabs:[ProductListVC] = []
    var cartItems = [ProductItem]()
    
    public static var __shared : FoodListVC?
    
    var tabTitles: [String] = ["Pizza", "Combo", "Sides", "Veberage", "New1", "New2"]
    var prevTabIndex:Int = 0
    var isReturn:Bool = false
    var hasSearchTab:Bool = false
    @IBAction func continueToCart(_ sender: Any) {
        if cartItems.count == 0 {
            showToast(message: "No items")
        } else {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.goToTabBarScreen(index: 3)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.	
        //        self.view.backgroundColor = UIColor(netHex: 0x364756)
        let logo = UIImage(named: "ic_logo")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        self.navigationController?.navigationBar.isHidden = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hidekeyBoard))
        view.addGestureRecognizer(tapGesture)
        hidekeyBoard()
        setUpTabs()
        FoodListVC.__shared = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(addCartItem(notification:)), name: Notification.Name("added_cart"), object: nil)
        
        setUpCartItems()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setUpViewPager(tindex: 0)
        for tab in tabs {
            tab.delegate = self
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        
        UIView.animate(withDuration: 1.5) {
            self.searchBorder.backgroundColor = .darkGray
        }
    }
    
    @objc func hidekeyBoard() {
        view.endEditing(true)
    }
    @IBAction func searchDisable(_ sender: Any) {
        searchView.isHidden = true
        tabs[viewPager!.currentTabIndex].loadData()
        searchTextF.text = nil
        view.endEditing(true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        setUpCartItems()
        self.navigationController?.navigationBar.isHidden = true
        self.searchView.isHidden = true //self.navigationController?.navigationBar.isHidden = false
        
    }
    
    func setUpCartItems() {
        if !searchView.isHidden
        {
            shouldHideKeyboard()
            tabs[viewPager!.currentTabIndex].loadData()
            return
        }
        cartItems = AppConstants.getCartItems()
        if cartItems.count > 0{
            viewShowBtn.isHidden =  false
        } else {
            viewShowBtn.isHidden = true
        }
        
        var sum_price = Float(0.0)
        var sum_count = 0
        for item in cartItems {
            sum_price += item.getPrice() * Float(item.getCount())
            sum_count += item.getCount()
        }
        lblCart.text = "\(sum_count) Item : $\(String(format: "%.2f", sum_price))"
        
        let orderItemData = AppConstants.getCartItems()
        if orderItemData.isEmpty == false {
        if let tabItems = tabBarController?.tabBar.items {
            
            // In this case we want to modify the badge number of the third tab:
            let tabItem = tabItems[3]
            tabItem.badgeValue = String(sum_count)
        }
        } else {
            if let tabItems = tabBarController?.tabBar.items {
                
                // In this case we want to modify the badge number of the third tab:
                let tabItem = tabItems[3]
                tabItem.badgeValue = nil
            }
        }
    }
    
    func shouldHideKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isReturn = false
        searchBorder.backgroundColor = UIColor(red: 0, green: 174, blue: 239)
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if(!hasSearchTab)
        {
            prevTabIndex = viewPager!.currentTabIndex
            hasSearchTab = true
            tabTitles.append("Search Result")
            setUpTabs()
            setUpViewPager(tindex:tabTitles.count - 1)
        }
        productListVC = tabs[viewPager!.currentTabIndex]
        productListVC?.searchData(text: textField.text!)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
      
        if(!isReturn)
        {
            if(hasSearchTab)
            {
                tabTitles.remove(at:tabTitles.count - 1)
                setUpTabs()
                setUpViewPager(tindex:prevTabIndex)
                hasSearchTab = false
            }
            searchBorder.backgroundColor = .gray
            textField.text = nil
            searchView.isHidden = true
            tabs[viewPager!.currentTabIndex].loadData()
            UIView.animate(withDuration: 1.5) {
                      self.searchBorder.backgroundColor = .darkGray
            }
        }
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        isReturn = true
        self.view.endEditing(true)
        return false
    }
    @IBAction func onSearch(_ sender: Any) {
        searchView.isHidden = false
        searchTextF.becomeFirstResponder()
        UIView.animate(withDuration: 1.5) {
            self.searchBorder.backgroundColor = .blue
        }
    }
    
    @IBAction func contactVc(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "contactVC") as! ContactVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setUpViewPager(tindex:Int){
        let frame =  CGRect(x:0, y: 0, width: viewMain.frame.size.width, height: viewMain.frame.size.height)
        viewPager = WormTabStrip(frame: frame)
        viewMain.addSubview(viewPager!)
        viewPager!.delegate = self
        viewPager!.eyStyle.wormStyel = .BUBBLE
        viewPager!.eyStyle.isWormEnable = false
        viewPager!.eyStyle.spacingBetweenTabs = 10
        viewPager!.eyStyle.tabItemSelectedColor = UIColor.init(red: 0, green: 174, blue: 239)
        viewPager!.eyStyle.tabItemDefaultFont = UIFont(name:"HelveticaNeue-Bold", size: 18.0)!
        viewPager!.currentTabIndex = tindex
        viewPager!.buildUI()
    }
//
    func setUpTabs(){
        for i in 1...tabTitles.count {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "productListVC") as! ProductListVC
            vc.delegate = self
           // productListVC = vc

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
        var sum_count = 0
        for item in cartItems {
            sum_price += item.getPrice() * Float(item.getCount())
            sum_count += item.getCount()
        }
        lblCart.text = "\(sum_count) Item : $\(String(format: "%.2f", sum_price))"
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
