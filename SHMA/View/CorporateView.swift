//
//  CorporateView.swift
//  SHMA
//
//  Created by Umar Yaqub on 24/12/2018.
//  Copyright © 2018 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

protocol CorporateViewDelegate: class {
    func didPressSearch()
}

class CorporateView: UIView {
    
    var corporateViewModel: CorporateViewModel!
    weak var delegate: CorporateViewDelegate?
    
    let mainlabel: UILabel = {
        let lable = UILabel()
        lable.numberOfLines = 0
        lable.textAlignment = .center
        lable.text = "Please search the member using their First Name and DOB."
        return lable
    }()
    let firstNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "First Name"
        tf.layer.borderWidth = 0.5
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.textAlignment = .center
        tf.layer.cornerRadius = 7
        return tf
    }()
    let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        dp.maximumDate = Date()
        return dp
    }()
    lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Search", for: .normal)
        button.addTarget(self, action: #selector(handleSearchAction), for: .touchUpInside)
        return button
    }()
    @objc private func handleSearchAction() {
        delegate?.didPressSearch()
    }
    
    var mainLabelBottomAnchor: NSLayoutConstraint?
    var mainLabelWidthAnchor: NSLayoutConstraint?
    var mainLabelRightAnchor: NSLayoutConstraint?
    var mainLabelCenterXAnchor: NSLayoutConstraint?
     var mainLabelCenterYAnchor: NSLayoutConstraint?
    
    var datePickerWidthAnchor: NSLayoutConstraint?
    var datePickerCenterXAnchor: NSLayoutConstraint?
    
    required init(traitCollection: UITraitCollection) {
        super.init(frame: .zero)
        
        corporateViewModel = CorporateViewModel(traitCollection, mainlabel, firstNameTextField, datePicker, self)
        
        addSubview(mainlabel)
        addSubview(firstNameTextField)
        addSubview(datePicker)
        addSubview(searchButton)
        
        disableAnchors()
        setupMainLabelAndSeachButton()
        setupFirstNameTextFieldAndDatePicker()
    }
    
    private func disableAnchors() {
        mainLabelCenterXAnchor?.isActive = false
        mainLabelCenterYAnchor?.isActive = false
        mainLabelBottomAnchor?.isActive = false
        mainLabelWidthAnchor?.isActive = false
        mainLabelRightAnchor?.isActive = false
        datePickerCenterXAnchor?.isActive = false
        datePickerWidthAnchor?.isActive = false
    }
    
    private func setupMainLabelAndSeachButton() {
        mainlabel.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100, centerYAnchor: nil, centerXAnchor: nil)
        
        mainLabelCenterXAnchor = corporateViewModel.getMainLabelCenterXAnchor()
        mainLabelCenterXAnchor?.isActive = true
        
        mainLabelCenterYAnchor = corporateViewModel.getMainLabelCenterYAnchor()
        mainLabelCenterYAnchor?.isActive = true
        
        mainLabelBottomAnchor = corporateViewModel.getMainLabelBottomAnchor()
        mainLabelBottomAnchor?.isActive = true
        
        mainLabelWidthAnchor = corporateViewModel.getMainLabelWidthAnchor()
        mainLabelWidthAnchor?.isActive = true
        
        mainLabelRightAnchor = corporateViewModel.getMainLabelRightAnchor()
        mainLabelRightAnchor?.isActive = true
        
        mainlabel.font = corporateViewModel.getMainLabelFontForEachDevice()
        
        searchButton.anchor(top: datePicker.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: corporateViewModel.getSearchButtonTopPadding(), paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 70, centerYAnchor: nil, centerXAnchor: datePicker.centerXAnchor)
        searchButton.widthAnchor.constraint(equalTo: datePicker.widthAnchor, multiplier: 0.5).isActive = true
        searchButton.titleLabel?.font = corporateViewModel.getSearchButtonFontForEachDevice()
    }
    
    private func setupFirstNameTextFieldAndDatePicker() {
        firstNameTextField.anchor(top: nil, left: nil, bottom: datePicker.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: corporateViewModel.getFirstNameTextFieldBottomPadding(), paddingRight: 0, width: 0, height: corporateViewModel.getFirstNameTextFieldHeightForEachDevice(), centerYAnchor: nil, centerXAnchor: datePicker.centerXAnchor)
        firstNameTextField.widthAnchor.constraint(equalTo: datePicker.widthAnchor).isActive = true
        firstNameTextField.font = corporateViewModel.getFirstNameTextFieldFontForEachDevice()
        
        datePicker.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 150, centerYAnchor: centerYAnchor, centerXAnchor: nil)
        
        datePickerCenterXAnchor = corporateViewModel.getDatePickerCenterXAnchor()
        datePickerCenterXAnchor?.isActive = true
        
        datePickerWidthAnchor = corporateViewModel.getDatePickerWidthAnchor()
        datePickerWidthAnchor?.isActive = true
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        corporateViewModel.traitCollection = traitCollection
        disableAnchors()
        setupMainLabelAndSeachButton()
        setupFirstNameTextFieldAndDatePicker()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

