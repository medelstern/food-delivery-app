//
//  CartVC.swift
//  DeliveryApp
//
//  Created by kh on 8/14/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func hideKeyBoard() {
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyBoard() {
        view.endEditing(true)
    }
}

class CartVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    
    var count : Int = 1
   
    var orderItemData: [OrderedProductItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let logo = UIImage(named: "ic_logo")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        self.hideKeyBoard()
        loadData()
 
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func onSearch(_ sender: Any) {
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emptyView.isHidden = true
        if orderItemData.count == 0 {
            emptyView.isHidden = false
        }
        if let tabItems = tabBarController?.tabBar.items {
            // In this case we want to modify the badge number of the third tab:
            let tabItem = tabItems[3]
            tabItem.badgeValue = String(orderItemData.count)
        }
        return orderItemData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderProductListCell", for: indexPath) as! OrderProductListCell
        let data = orderItemData[indexPath.row]
        cell.setOrderProductData(data: data)
        cell.selectionStyle = .none
        cell.btnIncrease.tag = indexPath.row + 1000
        cell.btnDecrease.tag = indexPath.row + 2000
        cell.txtCount.tag = indexPath.row + 3000
        
        cell.btnIncrease.addTarget(self, action: #selector(increateBtn1Tapped), for: .touchUpInside)
        cell.btnDecrease.addTarget(self, action: #selector(decreateBtn1Tapped), for: .touchUpInside)
        
        return cell
    }
    
    @IBAction func onBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnContinueClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "placeOrderVC")as! PlaceOrderVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func decreateBtn1Tapped(sender: UIButton) {
        let tagID = sender.tag
        let label = self.view.viewWithTag(tagID + 1000) as! UILabel
        count = Int(label.text!)!
        if count > 1 {
            count -= 1
            label.text = "\(count)"
        } else {
            let alertController = UIAlertController(title: "WARNING", message:
                "Are you sure you want to remove this item?", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                self.orderItemData.remove(at: sender.tag - 2000)
                self.tableView.reloadData()
            }))
            
            alertController.addAction(UIAlertAction(title: "No", style: .default, handler: { (action) in }))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc func increateBtn1Tapped(sender: UIButton) {
        let tagID = sender.tag
        let label = self.view.viewWithTag(tagID + 2000) as! UILabel
        count = Int(label.text!)! + 1
        label.text = "\(count)"
    }
   
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            print("notification: Keyboard will show")
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height - 20
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height - 20
            }
            self.view.frame.origin.y = 0
        }
    }
    
    override func viewWillAppear(_ animated: Bool){
        self.navigationController?.navigationBar.isHidden = false
        
    }
    
    func loadData() {
        let cartItems = AppConstants.getCartItems()
        if cartItems.count > 0 {
            var number : Int = 0
            for _ in 1...cartItems.count {
                orderItemData.append(OrderedProductItem(image: "1", title: "FARM HOUSE", feature: "Medium | New Hand tossed", desc: "Black Olives, Onion, capsicum, tomato, griled mushroom, golden corn, Jalapeno, Extra cheese", price: 5.99, count: cartItems[number].getCount()))
                number += 1
            }
        }
        self.tableView.reloadData()
    }
}
