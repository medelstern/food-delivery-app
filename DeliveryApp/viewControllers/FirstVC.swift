//
//  FirstVC.swift
//  DeliveryApp
//
//  Created by Jhon Paulo on 2020/1/13.
//  Copyright © 2020 dbug-mac. All rights reserved.
//

import UIKit

class FirstVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var deliveryView: UIView!
    
    @IBOutlet weak var collectionView: UIView!
    
    @IBOutlet weak var collectionSubView: UIView!
    @IBOutlet weak var deliverySubView: UIView!
    @IBOutlet weak var collectionContainerView: UIView!
    @IBOutlet weak var deliveryContainerView: UIView!
    @IBOutlet weak var buttonContinue: UIButton!
    @IBOutlet weak var postCodeText: UITextField!
    
    @IBOutlet weak var codeBottomBorder: UIView!
    
    @IBOutlet weak var postCodeLb: UILabel!
    var isDelivery:Bool = true
    var isCollection:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }

    func initView()
    {
        deliveryView.layer.cornerRadius = 5
         deliverySubView.layer.cornerRadius = 5
        deliveryView.borderWidth = 1
        deliveryView.borderColor = .init(red: 235, green: 235, blue: 235)
        collectionView.layer.cornerRadius = 5
         collectionSubView.layer.cornerRadius = 5
        collectionView.borderWidth = 1
        collectionView.borderColor = .init(red: 235, green: 235, blue: 235)
        setSelection()
        hideKeyBoard()
      
    }
    func setSelection()
    {
        if(isDelivery)
        {
            deliverySubView.backgroundColor = .init(red: 235, green: 235, blue: 235)
            deliveryView.backgroundColor = .init(red: 235, green: 235, blue: 235)
            collectionSubView.backgroundColor = .white
            collectionView.backgroundColor = .white
            UIView.animate(withDuration: 0.15, animations: {
                self.collectionContainerView.alpha = 0
                self.buttonContinue.alpha = 0
            }) { (_) in
                self.buttonContinue.setTitle("Continue", for: .normal)
                UIView.animate(withDuration: 0.15) {
                    self.deliveryContainerView.alpha = 1
                    self.buttonContinue.alpha = 1
                }
            }
        }
        if(isCollection)
        {
            deliverySubView.backgroundColor = .white
            deliveryView.backgroundColor = .white
            collectionSubView.backgroundColor = .init(red: 235, green: 235, blue: 235)
            collectionView.backgroundColor = .init(red: 235, green: 235, blue: 235)
            UIView.animate(withDuration: 0.15, animations: {
                self.deliveryContainerView.alpha = 0
                self.buttonContinue.alpha = 0
            }) { (_) in
                self.buttonContinue.setTitle("Confirm", for: .normal)
                UIView.animate(withDuration: 0.15) {
                    self.collectionContainerView.alpha = 1
                    self.buttonContinue.alpha = 1
                }
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           self.view.endEditing(true)
           return false
       }
       func textFieldDidEndEditing(_ textField: UITextField) {
        codeBottomBorder.backgroundColor = .gray
        postCodeLb.textColor =  .gray
       }
       func textFieldDidBeginEditing(_ textField: UITextField) {
          codeBottomBorder.backgroundColor = UIColor(red: 0, green: 174, blue: 239)
          postCodeLb.textColor =  UIColor(red: 0, green: 174, blue: 239)
       }

    @IBAction func continueTap(_ sender: Any) {
        print("continue")
    }
    
    @IBAction func collectionTap(_ sender: Any) {
      isCollection = true
      isDelivery = false
      setSelection()
    }
    
    @IBAction func deliveryTap(_ sender: Any) {
       isDelivery = true
       isCollection = false
        setSelection()
    }
}
