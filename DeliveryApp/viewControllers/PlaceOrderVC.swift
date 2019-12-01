//
//  ViewController.swift
//  DeliveryApp
//
//  Created by dbug-mac on 08/08/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import UIKit
import iOSDropDown

class PlaceOrderVC: UIViewController {

    @IBOutlet weak var btnDeliveryTime: UIButton!
    @IBOutlet weak var btnCollectionTim: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var btnDeliverySel: UIButton!
    @IBOutlet weak var btnCollectionSel: UIButton!
    @IBOutlet weak var homeAddressView: UIView!
    @IBOutlet weak var officeAddressView: UIView!
    @IBOutlet weak var HomeContainer: UIView!
    @IBOutlet weak var OfficeContainer: UIView!
   
    @IBOutlet weak var deliTimeDropdown: DropDown!
    @IBOutlet weak var collTimeDropdown: DropDown!
    
    var goNextEnable : Bool = false
    
//    @IBOutlet weak var timeIntervalPicker: LETimeIntervalPicker! {
//        didSet {
//            timeIntervalPicker.set(numberOfRows: 60, for: .minutes)
//            timeIntervalPicker.set(numberOfRows: 4, for: .hours)
//            timeIntervalPicker.components = [.hours, .minutes]
//        }
//    }
    var delivery_timer_clicked = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.isHidden = true
   
        self.displayDropdown()
        
//        let min = dateFormatter.date(from: "9:00")
//        let max = dateFormatter.date(from: "12:00")
//        datePicker.minimumDate = min
//        datePicker.maximumDate = max
//        
//        var components = Calendar.current.dateComponents([.hour, .minute, .month, .year, .day], from: datePicker.date)
//        
//        if components.hour! < 7 {
//            components.hour = 7
//            components.minute = 0
//            datePicker.setDate(Calendar.current.date(from: components)!, animated: true)
//        }
//        else if components.hour! > 21 {
//            components.hour = 21
//            components.minute = 59
//            datePicker.setDate(Calendar.current.date(from: components)!, animated: true)
//        }
//        else {
//            print("Everything is fine!")
//        }
        
        homeAddressView.layer.borderWidth = 1
        homeAddressView.layer.borderColor = UIColor.init(red: 0, green: 174, blue: 239).cgColor
        homeAddressView.layer.cornerRadius = 5
    }
    
    override func viewWillAppear(_ animated: Bool){
        self.navigationController?.navigationBar.isHidden = true
        
    }

    @IBAction func actnConfirm(_ sender: Any) {
        if goNextEnable {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PaymentVC")as! PaymentVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
                showToast(message: "Please select time.")
        }
       }
    
    @IBAction func onBackPressed(_ sender: Any) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onHomeRemove(_ sender: Any) {
        let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to remove?", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            
            self.HomeContainer.isHidden = true
        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            
        }
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    
    @IBAction func onOfficeRemove(_ sender: Any) {
        let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to remove?", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            
            self.OfficeContainer.isHidden = true
        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            
        }
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
  
    
    @IBAction func btnChangePressed(_ sender: Any) {
                
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddAddressVC")as! AddAddressVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func deliverySelPressed(_ sender: Any) {
        btnDeliverySel.setImage(UIImage(named: "green"), for: .normal)
        btnCollectionSel.setImage(UIImage(named: "gray"), for: .normal)
    }
    
    @IBAction func collectionSelPressed(_ sender: Any) {
        btnDeliverySel.setImage(UIImage(named: "gray"), for: .normal)
        btnCollectionSel.setImage(UIImage(named: "green"), for: .normal)
    }
    
    @IBAction func homeAddressSelected(_ sender: Any) {
        officeAddressView.layer.borderWidth = 0

        homeAddressView.layer.borderWidth = 1
        homeAddressView.layer.borderColor = UIColor.init(red: 0, green: 174, blue: 239).cgColor
        homeAddressView.layer.cornerRadius = 5
    }
    
    @IBAction func officeAddressSelected(_ sender: Any) {
        homeAddressView.layer.borderWidth = 0

        officeAddressView.layer.borderWidth = 1
        officeAddressView.layer.borderColor = UIColor.init(red: 0, green: 174, blue: 239).cgColor
        officeAddressView.layer.cornerRadius = 5
    }
    
    func displayDropdown() {
        self.deliTimeDropdown.selectedRowColor = UIColor.white
        self.collTimeDropdown.selectedRowColor = UIColor.white
       
        self.deliTimeDropdown.listWillAppear {
            self.view.gestureRecognizers?.forEach(self.view.removeGestureRecognizer)
        }
        self.deliTimeDropdown.listWillDisappear {
            self.goNextEnable = true
            self.hideKeyBoard()
        }
        deliTimeDropdown.optionArray = ["ASAP", "06:00", "06:30", "07:00", "07:30", "08:00", "08:30", "09:00", "09:30", "10:00", "10:30", "11:00", "11:30", "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30", "16:00", "16:30", "17:00", "17:30", "18:00", "18:30"]
        deliTimeDropdown.optionIds = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26]
        
        self.collTimeDropdown.listWillAppear {
            self.view.gestureRecognizers?.forEach(self.view.removeGestureRecognizer)
            
        }
        self.collTimeDropdown.listWillDisappear {
            self.hideKeyBoard()
            self.goNextEnable = true
        }
        collTimeDropdown.optionArray = ["ASAP","06:00", "06:30", "07:00", "07:30", "08:00", "08:30", "09:00", "09:30", "10:00", "10:30", "11:00", "11:30", "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30", "16:00", "16:30", "17:00", "17:30", "18:00", "18:30"]
        collTimeDropdown.optionIds = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26]
    }
    
    private func showTimePicker() {
//        DatePickerPopover(title: "")
//            .setDateMode(.time)
//            .setSelectedDate(Date())
//            .setMinuteInterval(43)
//            .setDoneButton(action: { popover, selectedDate in
//                let str = DateUtils.convertDateToStr(date: selectedDate, format: "HH:mm:ss")
//            })
//            .setCancelButton(action: { _, _ in })
//            .appear(originView: btnDeliveryTime, baseViewController: self)
    }
}

