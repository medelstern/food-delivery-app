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


    @IBOutlet weak var txtPostCode: FormTextField!
    
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtAddress2: UITextField!
    @IBOutlet weak var txtAddress1: UITextField!
    @IBOutlet weak var postCodeBorder: UILabel!
    @IBOutlet weak var chooseBorder: UILabel!
    @IBOutlet weak var homeBorder: UILabel!
    @IBOutlet weak var addressBorder: UILabel!
    @IBOutlet weak var address2Border: UILabel!
    @IBOutlet weak var cityBorder: UILabel!
    @IBOutlet weak var ppostcode: UILabel!
    
    @IBOutlet weak var postCodeLabel: UILabel!
    
    @IBOutlet weak var addressTitleLabel: UILabel!
    
    @IBOutlet weak var address1Label: UILabel!
    
    @IBOutlet weak var address2Label: UILabel!
    
    @IBOutlet weak var ppostCodeLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.hideKeyBoard()
        self.displayDropdown()
        
        var validation = Validation()
        validation.maximumLength = "EC1A 1BB".count
        validation.minimumLength = "EC1A 1BB".count
        let inputValidator = InputValidator(validation: validation)
        txtPostCode.inputValidator = inputValidator
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        postCodeBorder.backgroundColor = .gray
        chooseBorder.backgroundColor = .gray
        homeBorder.backgroundColor = .gray
        addressBorder.backgroundColor = .gray
        address2Border.backgroundColor = .gray
        cityBorder.backgroundColor = .gray
        ppostcode.backgroundColor = .gray
        
        postCodeLabel.textColor =  .gray
        addressTitleLabel.textColor = .gray
        address1Label.textColor =  .gray
        address2Label.textColor =  .gray
        cityLabel.textColor =  .gray
        ppostCodeLabel.textColor =  .gray
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if(textField == txtPostCode)
        {
            if(textField.text!.count > 8)
            {
                let pcodeText = textField.text!
                textField.text = String(pcodeText.dropLast())
            }
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 0 {
            postCodeBorder.backgroundColor = UIColor(red: 0, green: 174, blue: 239)
            postCodeLabel.textColor =  UIColor(red: 0, green: 174, blue: 239)
        }else if textField.tag == 1 {
            chooseBorder.backgroundColor = UIColor(red: 0, green: 174, blue: 239)
        }else if textField.tag == 2 {
            homeBorder.backgroundColor = UIColor(red: 0, green: 174, blue: 239)
            addressTitleLabel.textColor =  UIColor(red: 0, green: 174, blue: 239)
        }else if textField.tag == 3 {
          addressBorder.backgroundColor = UIColor(red: 0, green: 174, blue: 239)
          address1Label.textColor =  UIColor(red: 0, green: 174, blue: 239)
        }else if textField.tag == 4 {
            address2Border.backgroundColor = UIColor(red: 0, green: 174, blue: 239)
            address2Label.textColor =  UIColor(red: 0, green: 174, blue: 239)
        }else if textField.tag == 5 {
            cityBorder.backgroundColor = UIColor(red: 0, green: 174, blue: 239)
            cityLabel.textColor =  UIColor(red: 0, green: 174, blue: 239)
        } else {
            ppostcode.backgroundColor = UIColor(red: 0, green: 174, blue: 239)
            ppostCodeLabel.textColor =  UIColor(red: 0, green: 174, blue: 239)
        }
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
        AppConstants.addressList.append(AddressItem(type: txtAddressTitle.text!, address: txtAddress1.text! + ", " +  txtCity.text! + ", " + txtPostCode.text!))
        
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
