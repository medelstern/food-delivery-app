//
//  LoginVC.swift
//  DeliveryApp
//
//  Created by Star on 10/11/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var passBorder: UILabel!
    @IBOutlet weak var loginBorder: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var usernameLeftSpace: NSLayoutConstraint!
    
    @IBOutlet weak var usernameRightSpace: NSLayoutConstraint!
    
    @IBOutlet weak var nameLbLeftSpace: NSLayoutConstraint!
    
    @IBOutlet weak var nameInputRightSpace: NSLayoutConstraint!
    
    @IBOutlet weak var passwordLeftSpace: NSLayoutConstraint!
    @IBOutlet weak var passwordRightSpace: NSLayoutConstraint!
    
    @IBOutlet weak var passwordInpright: NSLayoutConstraint!
    @IBOutlet weak var passwordLbLeft: NSLayoutConstraint!
    @IBOutlet weak var loginLeftSpace:
    NSLayoutConstraint!
    @IBOutlet weak var loginRightSpace: NSLayoutConstraint!
    @IBOutlet weak var registerLeftSpace: NSLayoutConstraint!
    @IBOutlet weak var registerRightSpace: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad)
        {
            let s_space:CGFloat = 150.0
            usernameLeftSpace.constant = s_space
            usernameRightSpace.constant = s_space
            nameLbLeftSpace.constant  = s_space + 10
            nameInputRightSpace.constant = s_space + 10
            passwordLeftSpace.constant = s_space
            passwordRightSpace.constant = s_space
            passwordLbLeft.constant = s_space + 10
            passwordInpright.constant = s_space + 10
            loginLeftSpace.constant = s_space
            loginRightSpace.constant = s_space
            registerLeftSpace.constant = s_space
            registerRightSpace.constant = s_space
        }
        
        // Do any additional setup after loading the view.
        self.hideKeyBoard()
    }
    @IBAction func btnLoginPressed(_ sender: Any) {
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.menuVC()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        passBorder.backgroundColor = .gray
            loginBorder.backgroundColor = .gray
        nameLabel.textColor =  .gray
        passwordLabel.textColor =  .gray
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            passBorder.backgroundColor = UIColor(red: 0, green: 174, blue: 239)
            passwordLabel.textColor =  UIColor(red: 0, green: 174, blue: 239)
            
        } else {
            loginBorder.backgroundColor = UIColor(red: 0, green: 174, blue: 239)
            nameLabel.textColor =  UIColor(red: 0, green: 174, blue: 239)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
