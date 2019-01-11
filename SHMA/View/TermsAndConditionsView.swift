//
//  TermsAndConditionsView.swift
//  SHMA
//
//  Created by Umar Yaqub on 10/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit
import WebKit

protocol TermsAndConditionsViewDelegate: class {
    func didPressAgree()
    func didPressDisagree()
}

class TermsAndConditionsView: UIView, WKUIDelegate {
    
    lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let wv = WKWebView(frame: .zero, configuration: webConfiguration)
        wv.uiDelegate = self
        return wv
    }()
    lazy var agreeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Agree", for: .normal)
        button.addTarget(self, action: #selector(handleAgree), for: .touchUpInside)
        return button
    }()
    lazy var disagreeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Disagree", for: .normal)
        button.addTarget(self, action: #selector(handleDisagree), for: .touchUpInside)
        return button
    }()
    let buttonSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 220, green: 220, blue: 220)
        return view
    }()
    
    weak var delegate: TermsAndConditionsViewDelegate?
    var termsAndConditionsViewModel: TermsAndConditionsViewModel!
    
    required init(traitCollection: UITraitCollection) {
        super.init(frame: .zero)
        backgroundColor = .white
        termsAndConditionsViewModel = TermsAndConditionsViewModel(traitCollection, termsAndConditionsView: self)
        
        setupView()
    }
    
    private func setupView() {
        addSubview(webView)
        addSubview(agreeButton)
        addSubview(disagreeButton)
        addSubview(buttonSeperatorView)
        
        setupWebView()
        setupButtons()
    }
    
    private func setupWebView() {
        webView.anchor(top: topAnchor, left: leftAnchor, bottom: agreeButton.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        
        let myURL = URL(fileReferenceLiteralResourceName: "Terms&Conditionsv8.pdf")
        let myRequest = URLRequest(url: myURL)
        webView.load(myRequest)
    }
    
    private func setupButtons() {
        agreeButton.anchor(top: nil, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 3, paddingRight: 3, width: 120, height: 40, centerYAnchor: nil, centerXAnchor: nil)
        agreeButton.titleLabel?.font = termsAndConditionsViewModel.getAgreeButtonFontForEachDevice()
        
        disagreeButton.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 3, paddingBottom: 3, paddingRight: 0, width: 120, height: 40, centerYAnchor: nil, centerXAnchor: nil)
        disagreeButton.titleLabel?.font = termsAndConditionsViewModel.getDisagreeButtonFontForEachDevice()
        
        buttonSeperatorView.anchor(top: nil, left: leftAnchor, bottom: agreeButton.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5, centerYAnchor: nil, centerXAnchor: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
