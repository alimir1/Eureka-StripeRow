//
//  ViewController.swift
//  EurekaStripeRowExample
//
//  Created by Ali Mir on 6/17/17.
//  Copyright © 2017 com.AliMir. All rights reserved.
//

import UIKit
import Eureka
import Stripe

class ViewController: FormViewController {
    
    var payBarButton = UIBarButtonItem()
    var paymentField = STPPaymentCardTextField()
    
    var totalPrice: Double = 0.0 {
        didSet {
            if let row = form.rowBy(tag: "TotalPriceRow") {
                // FIXME: - Update total price label here
                row.title = "Total:\t$100)"
            } else {
                print("ViewController: Couldn't get row from tag: \"TotalPriceRow\"")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Pay UIBarButtonItem
        payBarButton = UIBarButtonItem(
            title: "Pay",
            style: .plain,
            target: self,
            // FIXME: - Payment button pressed action
            action: nil
        )
        
        payBarButton.isEnabled = false
        
        self.navigationItem.rightBarButtonItem = payBarButton
        
        form +++
            Section("Git Fundamentals: From Beginner to Boss")
            
            <<< NameRow() {
                $0.title = "Name"
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
                } .cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                    self.payBarButton.isEnabled = self.isValidForm()
            }
            
            <<< EmailRow() {
                $0.title = "Email"
                $0.add(rule: RuleRequired())
                $0.add(rule: RuleEmail())
                $0.validationOptions = .validatesOnChange
                } .cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                    self.payBarButton.isEnabled = self.isValidForm()
            }
            
            <<< PhoneRow() {
                $0.title = "Phone"
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
                } .cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                    self.payBarButton.isEnabled = self.isValidForm()
            }
            
            
            <<< PickerInlineRow<Int>() {
                $0.title = "Total number of guests"
                $0.options = [1, 2, 3, 4, 5, 6, 7]
                $0.noValueDisplayText = "Please Select"
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
                } .cellUpdate { cell, row in
                    self.payBarButton.isEnabled = self.isValidForm()
            }
            
            <<< PickerInlineRow<String>() {
                $0.title = "Date & Time"
                $0.options = ["Thu, Dec 31 at 12:59 PM", "Sat, Jan 31 at 12:59 PM", "Wed, Dec 31 at 12:59 PM"]
                $0.noValueDisplayText = "Please Select"
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
                } .cellUpdate { cell, row in
                    self.payBarButton.isEnabled = self.isValidForm()
        }
        
        form +++
            Section(footer: "Credit or Debit Card")
            <<< StripeRow().cellUpdate { cell, row in
                self.paymentField = cell.paymentField
                self.payBarButton.isEnabled = self.isValidForm()
        }
        
        form +++
            Section()
            <<< LabelRow() {
                $0.tag = "TotalPriceRow"
        }
        
        // Enables smooth scrolling on navigation to off-screen rows
        animateScroll = true
        // Leaves 20pt of space between the keyboard and the highlighted row after scrolling to an off screen row
        rowKeyboardSpacing = 20
    }
    
    // Validation
    func isValidForm() -> Bool {
        if !paymentField.isValid {
            return false
        }
        self.paymentField.borderColor = .clear
        for row in form.allRows {
            if  !row.isValid {
                return false
            }
        }
        return true
    }
}

