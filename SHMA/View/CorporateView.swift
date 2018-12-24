//
//  CorporateView.swift
//  SHMA
//
//  Created by Umar Yaqub on 24/12/2018.
//  Copyright © 2018 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

class CorporateView: UIView {
    
    let label: UILabel = {
        let lable = UILabel()
        lable.numberOfLines = 0
        return lable
    }()
    let firstNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "First Name"
        return tf
    }()
    let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        return dp
    }()
    lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Search", for: .normal)
        return button
    }()
    
    required init(traitCollection: UITraitCollection) {
        super.init(frame: .zero)
        
        addSubview(label)
        addSubview(firstNameTextField)
        addSubview(datePicker)
        addSubview(searchButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
