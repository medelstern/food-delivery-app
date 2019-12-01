//
//  AddAddressVC.swift
//  DeliveryApp
//
//  Created by dbug-mac on 09/08/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import UIKit
import iOSDropDown

class AddAddressVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var addressDropDown: DropDown!
    
    @IBOutlet weak var txtAddressTitle: UITextField!
    
    @IBOutlet weak var txtPostCode: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtAddress2: UITextField!
    @IBOutlet weak var txtAddress1: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = true
        self.hideKeyBoard()
        self.displayDropdown()
        
    }
    
    override func viewWillAppear(_ animated: Bool){
        self.navigationController?.navigationBar.isHidden = true
        
    }

    @IBAction func actnBack(_ sender: Any) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.popViewController(animated: true)
    }   

    @IBAction func actnPayment(_ sender: Any) {
        
        if txtAddressTitle.text!.isEmpty{
            showToast(message: "Enter Address Title")
            return
        }
        
        if txtAddress1.text!.isEmpty{
            showToast(message: "Enter Address")
            return
        }
        
        if txtCity.text!.isEmpty{
            showToast(message: "Enter City")
            return
        }
        
        if txtPostCode.text!.isEmpty{
            showToast(message: "Enter PostCode")
            return
        }
        AppConstants.addressList.append(AddressItem(type: txtAddressTitle.text!, address: txtAddress1.text! + ", " +  txtCity.text!))
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.popViewController(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func displayDropdown() {
        self.addressDropDown.selectedRowColor = UIColor.white
        self.addressDropDown.listWillAppear {
            self.view.gestureRecognizers?.forEach(self.view.removeGestureRecognizer)
        }
        self.addressDropDown.listWillDisappear {
            self.hideKeyBoard()
        }
        addressDropDown.optionArray = ["Address1", "Address2", "Address3"]
        addressDropDown.optionIds = [21, 22, 23]        
    }
}
