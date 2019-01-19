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
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let iv = UIActivityIndicatorView()
        iv.style = .whiteLarge
        return iv
    }()
    let dimView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.6, alpha: 0.5)
        view.isHidden = true
        return view
    }()
    let mainlabel: UILabel = {
        let lable = UILabel()
        lable.numberOfLines = 0
        lable.textAlignment = .center
        lable.text = "Please search the member using their First Name and DOB."
        return lable
    }()
    let surnameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Last Name"
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
    
    var mainLabelBottomAnchor: NSLayoutConstraint?
    var mainLabelWidthAnchor: NSLayoutConstraint?
    var mainLabelRightAnchor: NSLayoutConstraint?
    var mainLabelLeftAnchor: NSLayoutConstraint?
    var mainLabelCenterXAnchor: NSLayoutConstraint?
    var mainLabelCenterYAnchor: NSLayoutConstraint?
    
    var datePickerWidthAnchor: NSLayoutConstraint?
    var datePickerCenterXAnchor: NSLayoutConstraint?
    
    required init(traitCollection: UITraitCollection) {
        super.init(frame: .zero)
        backgroundColor = .white
        
        corporateViewModel = CorporateViewModel(traitCollection, mainlabel, surnameTextField, datePicker, self)
        
        addSubview(mainlabel)
        addSubview(surnameTextField)
        addSubview(datePicker)
        addSubview(searchButton)
        
        addSubview(dimView)
        dimView.addSubview(activityIndicatorView)
        
        disableAnchors()
        setupMainLabelAndSeachButton()
        setuplastNameTextFieldAndDatePicker()
        setupDimViewAndActivityIndicatorView()
    }
    
    private func disableAnchors() {
        mainLabelCenterXAnchor?.isActive = false
        mainLabelCenterYAnchor?.isActive = false
        mainLabelBottomAnchor?.isActive = false
        mainLabelWidthAnchor?.isActive = false
        mainLabelRightAnchor?.isActive = false
        mainLabelLeftAnchor?.isActive = false
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
        
        mainLabelLeftAnchor = corporateViewModel.getMainLabelLeftAnchor()
        mainLabelLeftAnchor?.isActive = true
        
        mainlabel.font = corporateViewModel.getMainLabelFontForEachDevice()
        
        searchButton.anchor(top: datePicker.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: corporateViewModel.getSearchButtonTopPadding(), paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 70, centerYAnchor: nil, centerXAnchor: datePicker.centerXAnchor)
        searchButton.widthAnchor.constraint(equalTo: datePicker.widthAnchor, multiplier: 0.5).isActive = true
        searchButton.titleLabel?.font = corporateViewModel.getSearchButtonFontForEachDevice()
    }
    
    private func setuplastNameTextFieldAndDatePicker() {
        surnameTextField.delegate = self
        surnameTextField.anchor(top: nil, left: nil, bottom: datePicker.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: corporateViewModel.getlastNameTextFieldBottomPadding(), paddingRight: 0, width: 0, height: corporateViewModel.getlastNameTextFieldHeightForEachDevice(), centerYAnchor: nil, centerXAnchor: datePicker.centerXAnchor)
        surnameTextField.widthAnchor.constraint(equalTo: datePicker.widthAnchor).isActive = true
        surnameTextField.font = corporateViewModel.getlastNameTextFieldFontForEachDevice()
        
        datePicker.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 150, centerYAnchor: centerYAnchor, centerXAnchor: nil)
        
        datePickerCenterXAnchor = corporateViewModel.getDatePickerCenterXAnchor()
        datePickerCenterXAnchor?.isActive = true
        
        datePickerWidthAnchor = corporateViewModel.getDatePickerWidthAnchor()
        datePickerWidthAnchor?.isActive = true
        
    }
    
    private func setupDimViewAndActivityIndicatorView() {
        activityIndicatorView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: centerYAnchor, centerXAnchor: centerXAnchor)
        
        dimView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        corporateViewModel.traitCollection = traitCollection
        disableAnchors()
        setupMainLabelAndSeachButton()
        setuplastNameTextFieldAndDatePicker()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

