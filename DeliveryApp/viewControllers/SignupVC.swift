//
//  SignupVC.swift
//  DeliveryApp
//
//  Created by Star on 10/11/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import UIKit

class SignupVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var fullnameLb: UILabel!
    
    @IBOutlet weak var fullnameText: UITextField!
    
    @IBOutlet weak var fullnameBorder: UILabel!
    
    
    @IBOutlet weak var emailLb: UILabel!
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var emailBorder: UILabel!
    
    @IBOutlet weak var passwordLb: UILabel!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var passwordBorder: UILabel!
    
    @IBOutlet weak var phoneLb: UILabel!
    
    @IBOutlet weak var phoneText: UITextField!
    
    @IBOutlet weak var phoneBorder: UILabel!
    
    @IBOutlet weak var addressLb: UILabel!
    
    @IBOutlet weak var addressBorder: UILabel!
    
    @IBOutlet weak var addressText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.hideKeyBoard()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        fullnameBorder.backgroundColor = .gray
        fullnameLb.textColor = .gray
        emailBorder.backgroundColor = .gray
        emailLb.textColor = .gray
        passwordBorder.backgroundColor = .gray
        passwordLb.textColor = .gray
        phoneBorder.backgroundColor = .gray
        phoneLb.textColor = .gray
        addressBorder.backgroundColor = .gray
        addressLb.textColor = .gray
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if(textField == fullnameText)
        {
            fullnameBorder.backgroundColor = UIColor(red: 0, green: 174, blue: 239)
            fullnameLb.textColor = UIColor(red: 0, green: 174, blue: 239)
        }
        if(textField == emailText)
        {
           emailBorder.backgroundColor = UIColor(red: 0, green: 174, blue: 239)
            emailLb.textColor = UIColor(red: 0, green: 174, blue: 239)
        }
        if(textField == passwordText)
        {
           passwordBorder.backgroundColor = UIColor(red: 0, green: 174, blue: 239)
           passwordLb.textColor = UIColor(red: 0, green: 174, blue: 239)
        }
        if(textField == phoneText)
        {
           phoneBorder.backgroundColor = UIColor(red: 0, green: 174, blue: 239)
           phoneLb.textColor = UIColor(red: 0, green: 174, blue: 239)
        }
        if(textField == addressText)
        {
           addressBorder.backgroundColor = UIColor(red: 0, green: 174, blue: 239)
           addressLb.textColor = UIColor(red: 0, green: 174, blue: 239)
        }
        
          
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func btnSignupPressed(_ sender: Any) {
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.menuVC()
    }
    
    @IBAction func onTapLogin(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            print("notification: Keyboard will show")
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height - 100
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height - 100
            }
            self.view.frame.origin.y = 0
        }
    }

}
