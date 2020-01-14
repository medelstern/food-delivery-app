//
//  PaymentVC.swift
//  DeliveryApp
//
//  Created by dbug-mac on 09/08/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import UIKit

class PaymentVC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var cvvLbl: UILabel!
    @IBOutlet weak var btnCredit: UIButton!
    @IBOutlet weak var btnCash: UIButton!
    
    @IBOutlet weak var expLbl: UILabel!
    @IBOutlet weak var cardLbl: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cCashTop: NSLayoutConstraint!
    
    @IBOutlet weak var vCartInfo: UIView!
    
    @IBOutlet weak var cartViewH: NSLayoutConstraint!
    
    @IBOutlet weak var labelSubtotal: UILabel!
    @IBOutlet weak var labelTotal: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var cashView: UIView!
    
    @IBOutlet weak var txtFieldCardNumber: FormTextField!
    @IBOutlet weak var txtFieldExpDate: FormTextField!
    @IBOutlet weak var txtFieldCVV: FormTextField!
    @IBOutlet weak var labelOrderPrice: UILabel!
    
    @IBOutlet weak var subTotalView: UIView!
    
    @IBOutlet weak var deliveryChangeView: UIView!
    @IBOutlet weak var TotalView: UIView!
    
    @IBOutlet weak var deliveryChangeLabel: UILabel!
    
    @IBOutlet weak var deliveryChangePrice: UILabel!
    
    @IBOutlet weak var nameLb: UILabel!
    
    @IBOutlet weak var cardLb: UILabel!
    
    @IBOutlet weak var cvvLb: UILabel!
    @IBOutlet weak var expLb: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.hideKeyBoard()
        
        var subtotal: Float = 0
        
        for item in AppConstants.orderedProductList {
            subtotal += item.getPrice()*Float(item.getCount())
        }
        
        labelSubtotal.text = "$" + String(format: "%.2f", subtotal)
        labelTotal.text = "$" + String(format: "%.2f", subtotal+4.00)
        labelOrderPrice.text = "$" + String(format: "%.2f", subtotal+4.00)

        let tapCardView = UITapGestureRecognizer.init(target: self, action: #selector(tapCardView(_:)))
        cardView.addGestureRecognizer(tapCardView)
        let tapCashView = UITapGestureRecognizer.init(target: self, action: #selector(tapCashView(_:)))
        cashView.addGestureRecognizer(tapCashView)
        
        txtFieldCardNumber.inputType = .integer
        txtFieldCardNumber.formatter = CardNumberFormatter()
        
        var validation = Validation()
        validation.minimumLength = "1234 5678 1234 5678".count
        validation.maximumLength = "1234 5678 1234 5678".count
        let characterSet = NSMutableCharacterSet.decimalDigit()
        characterSet.addCharacters(in: " ")
        validation.characterSet = characterSet as CharacterSet
        let inputValidator = InputValidator(validation: validation)
        txtFieldCardNumber.inputValidator = inputValidator
        txtFieldCardNumber.textFieldDelegate = self
        txtFieldCardNumber.delegate = self

        
        txtFieldExpDate.inputType = .integer
        txtFieldExpDate.formatter = CardExpirationDateFormatter()
        
        var validation1 = Validation()
        validation1.minimumLength = 1
        let inputValidator1 = CardExpirationDateInputValidator(validation: validation1)
        txtFieldExpDate.inputValidator = inputValidator1
        txtFieldExpDate.textFieldDelegate = self
        txtFieldExpDate.delegate = self

        
        txtFieldCVV.inputType = .integer
        
        var validation2 = Validation()
        validation2.maximumLength = "CVC".count
        validation2.minimumLength = "CVC".count
        validation2.characterSet = CharacterSet.decimalDigits
        let inputValidator2 = InputValidator(validation: validation2)
        txtFieldCVV.inputValidator = inputValidator2
        txtFieldCVV.textFieldDelegate = self
        txtFieldCVV.delegate = self

        //added newly:pus
        if(PlaceOrderVC.selectedCollection)
        {
            subTotalView.isHidden = true
            TotalView.isHidden = true
            deliveryChangeLabel.text = "Total"
            deliveryChangePrice.text = "$" + String(format: "%.2f", subtotal+4.00)
        }
    }
   
    @objc func tapCardView(_ sender: UITapGestureRecognizer) {
        cardView.layer.borderWidth = 1
        cashView.layer.borderWidth = 0
    }
    
    @objc func tapCashView(_ sender: UITapGestureRecognizer) {
        cardView.layer.borderWidth = 0
        cashView.layer.borderWidth = 1
        view.endEditing(true)
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let borderColor = UIColor(red: 0, green: 174, blue: 239)
       
        if textField.tag == 4 {
            cardLbl.backgroundColor = borderColor
            cardLb.textColor = borderColor
        } else if textField.tag == 3 {
            cvvLbl.backgroundColor = borderColor
            cvvLb.textColor = borderColor
        } else if textField.tag == 2 {
            expLbl.backgroundColor = borderColor
            expLb.textColor = borderColor

        } else {
            nameLabel.backgroundColor = borderColor
            nameLb.textColor = borderColor
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
            cardLbl.backgroundColor = .gray
            cvvLbl.backgroundColor = .gray
            expLbl.backgroundColor = .gray
            nameLabel.backgroundColor = .gray
        
            cardLb.textColor = .gray
            cvvLb.textColor = .gray
            expLb.textColor = .gray
            nameLb.textColor = .gray
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
        cardView.layer.borderWidth = 1
        cashView.layer.borderWidth = 0
        
        self.vCartInfo.isHidden = false
        self.cartViewH.constant = 232
    }
    
    @IBAction func cashBtnPressed(_ sender: Any) {
        cardView.layer.borderWidth = 0
        cashView.layer.borderWidth = 1
        
        self.vCartInfo.isHidden = true
        self.cartViewH.constant = 63
        
        view.endEditing(true)
    }
}


extension PaymentVC: FormTextFieldDelegate {
    func formTextField(_ textField: FormTextField, didUpdateWithText _: String?) {
        if textField == txtFieldCVV {
            let len_str = textField.text!.count
            if len_str > 3
            {
                let ss = textField.text!
                textField.text = ss.take(3)
            }
        }
        if textField.validate() {
            if textField == txtFieldCardNumber {
                txtFieldExpDate.becomeFirstResponder()
            }
            if textField == txtFieldExpDate {
                txtFieldCVV.becomeFirstResponder()
            }
            if textField == txtFieldCVV {
                view.endEditing(true)
            }
        }
    }
}
extension String {
    func take(_ n: Int) -> String {
        guard n >= 0 else {
            fatalError("n should never negative")
        }
        let index = self.index(self.startIndex, offsetBy: min(n, self.count))
        return String(self[..<index])
    }
}
