//
//  StripeRow.swift
//  SlugBug
//
//  Created by Ali Mir on 6/16/17.
//  Copyright © 2017 com.AliMir. All rights reserved.
//

import UIKit
import Eureka
import Stripe

final class StripeCell: Cell<String>, CellType, STPPaymentCardTextFieldDelegate {
    
    var paymentField = STPPaymentCardTextField()
    
    required init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        paymentField = STPPaymentCardTextField()
        paymentField.frame = contentView.bounds
        self.contentView.addSubview(paymentField)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setup() {
        super.setup()
        
        selectionStyle = .none
        
        paymentField.backgroundColor = .white
        paymentField.cornerRadius = 0.0
        paymentField.borderColor = .clear
        
        paymentField.delegate = self
        
        height = { return 44 }
    }
    
    override func update() {
        super.update()
        textLabel?.text = nil
    }
    
    func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField) {
        formViewController()?.beginEditing(of: self)
    }
}

/**
 *  An Eureka Row for STPPaymentCardTextField.
 
 * Usage:
 
 form +++
    Section(footer: "Credit or Debit Card")
    <<< StripeRow().cellUpdate { cell, row in
    self.paymentField = cell.paymentField
    self.payBarButton.isEnabled = self.isValidForm()
 }
 */
final class StripeRow: Row<StripeCell>, RowType {
    required init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<StripeCell>()
    }
}
