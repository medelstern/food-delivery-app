//
//  OffersDiscountsVC.swift
//  DeliveryApp
//
//  Created by kh on 8/12/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import UIKit

class OffersDiscountsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var offersDiscountsData: [OffersDiscountsItem] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offersDiscountsData.count
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "offersDiscountsCell", for: indexPath) as! OffersDiscountsCell
        cell.setData(offersDiscountsData[indexPath.row])
        cell.cellView.tag = indexPath.row
    
            cell.cellView.addTarget(self, action: #selector(copiedCode), for: .touchUpInside)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.tableView.estimatedRowHeight = 150
//        self.tableView.rowHeight = UITableView.automaticDimension
        let logo = UIImage(named: "ic_logo")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        self.tableView.backgroundColor = UIColor.clear
        loadData()
    }
    
    @objc func copiedCode(sender: UIButton!) {
        UIPasteboard.general.string = offersDiscountsData[sender.tag].getActionTitle()
       
        let actionTitle : String = offersDiscountsData[sender.tag].getActionTitle()
        
        showToast(message: actionTitle)
    }
    
    func loadData() {
        offersDiscountsData.append(OffersDiscountsItem.init("New User? First Pizza Free!!", desc: "Oh! You're new User? Order your first pizza now for Free & just pay for delivery charges. Terms & Conditions apply.",actionTitle: "NEW4FREE"))
            
        offersDiscountsData.append(OffersDiscountsItem.init("Buy 2 Large Pizza & Get 1 Large for free", desc: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore.",actionTitle: "BUY2GET1"))
                
        offersDiscountsData.append(OffersDiscountsItem.init("Combo Bonanza 50% Off", desc: "Lorem ipsum dolor sit amet, consectetur adipidisicing elit, sed do eiusmod tempor incididunt ut labore et dolore", actionTitle: "COMBO50"))
                
        offersDiscountsData.append(OffersDiscountsItem.init("Buy 3 Medium & Get 2 Small Pizza for free", desc: "Oh! You're new User? Order your first pizza now for Free & just pay for delivery charges. Terms & Condition apply", actionTitle: "BUY3GET2"))
        self.tableView.reloadData()
    }

    @IBAction func onBackPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool){
        self.navigationController?.navigationBar.isHidden = false
        
    }
    
}
