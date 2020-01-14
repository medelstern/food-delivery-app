//
//  OrderVC.swift
//  DeliveryApp
//
//  Created by dbug-mac on 09/08/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import UIKit

class OrderVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool){
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    @IBAction func actnMyOrders(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.goToTabBarScreen(index: 1)
        if let tabItems = tabBarController?.tabBar.items {
            let orderItemData = AppConstants.getCartItems()
            var sum_count = 0
            for item in orderItemData {
                sum_count += item.getCount()
            }
            let tabItem = tabItems[3]
            tabItem.badgeValue = String(sum_count)
        }
    }
    
    @IBAction func actnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
