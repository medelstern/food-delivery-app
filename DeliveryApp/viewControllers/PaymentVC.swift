//
//  PaymentVC.swift
//  DeliveryApp
//
//  Created by dbug-mac on 09/08/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import UIKit

class PaymentVC: UIViewController {

    @IBOutlet weak var btnCredit: UIButton!
    @IBOutlet weak var btnCash: UIButton!
    
    @IBOutlet weak var cCashTop: NSLayoutConstraint!
    
    @IBOutlet weak var vCartInfo: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.hideKeyBoard()
    }
    
   
    
    override func viewWillAppear(_ animated: Bool){
        self.navigationController?.navigationBar.isHidden = true
        
    }
    

    @IBAction func actnPlaceOrer(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OrderVC")as! OrderVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func actnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func creditBtnPressed(_ sender: Any) {
        btnCredit.setImage(UIImage(named: "green"), for: .normal)
        btnCash.setImage(UIImage(named: "gray"), for: .normal)
        
        vCartInfo.isHidden = false
        cCashTop.constant = 190
    }
    
    @IBAction func cashBtnPressed(_ sender: Any) {
        btnCredit.setImage(UIImage(named: "gray"), for: .normal)
        btnCash.setImage(UIImage(named: "green"), for: .normal)
        
        vCartInfo.isHidden = true
        cCashTop.constant = 10.0
    }
}
