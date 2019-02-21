//
//  ProfileCell.swift
//  SHMA
//
//  Created by Umar Yaqub on 02/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {
    
    let detailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    let detailTextView: UITextView = {
        let tv = UITextView()
        tv.dataDetectorTypes = [.link, .phoneNumber]
        tv.isEditable = false
        tv.isScrollEnabled = false
        return tv
    }()

    var businessViewModel: BusinessViewModel? {
        didSet {
            guard let businessViewModel = businessViewModel else { return }
            detailTextView.font = businessViewModel.getLabelAndTextViewFontForEachDevice()
            detailLabel.font = businessViewModel.getLabelAndTextViewFontForEachDevice()
            detailLabel.textColor = businessViewModel.getLabelTextColour()
            setupLabelAndTextFieldConstraints()
        }
    }

    var profileViewModel: ProfileViewModel? {
        didSet {
            guard let profileViewModel = profileViewModel else { return }
            detailTextView.font = profileViewModel.getLabelAndTextViewFontForEachDevice()
            detailLabel.font = profileViewModel.getLabelAndTextViewFontForEachDevice()
            detailLabel.textColor = profileViewModel.getLabelTextColour()
            setupLabelAndTextFieldConstraints()
        }
    }
    
    private func setupLabelAndTextFieldConstraints() {
        if let profileViewModel = profileViewModel {
            detailLabelLeftAnchor = detailLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: profileViewModel.getMemberDetailLabelLeftPadding())
            detailLabelWidthAnchor = detailLabel.widthAnchor.constraint(equalToConstant: profileViewModel.getMemberDetailLabelWidth())
            detailTextViewLeftAnchor = detailTextView.leftAnchor.constraint(equalTo: detailLabel.rightAnchor, constant: profileViewModel.getMemberDetailTextViewLeftPadding())
        }
        if let businessViewModel = businessViewModel {
            detailLabelLeftAnchor = detailLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: businessViewModel.getMemberDetailLabelLeftPadding())
            detailLabelWidthAnchor = detailLabel.widthAnchor.constraint(equalToConstant: businessViewModel.getMemberDetailLabelWidth())
            detailTextViewLeftAnchor = detailTextView.leftAnchor.constraint(equalTo: detailLabel.rightAnchor, constant: businessViewModel.getMemberDetailTextViewLeftPadding())
        }
        detailLabelLeftAnchor?.isActive = true
        detailLabelWidthAnchor?.isActive = true
        detailTextViewLeftAnchor?.isActive = true
    }
    
    var detail: String? {
        didSet {
            let updatedString = detail?.replacingOccurrences(of: "[\\[\\]\"]", with: "", options: .regularExpression, range: nil)
            let removedUnderscores = updatedString?.replacingOccurrences(of: "_", with: " ")
            if businessViewModel != nil {
                detailTextView.text = removedUnderscores
            } else {
                detailTextView.text = updatedString
            }
        }
    }
    
    var label: String? {
        didSet {
            detailLabel.text = label
        }
    }
    
    var detailLabelLeftAnchor: NSLayoutConstraint?
    var detailLabelWidthAnchor: NSLayoutConstraint?
    var detailTextViewLeftAnchor: NSLayoutConstraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.isUserInteractionEnabled = false
        
        addSubview(detailLabel)
        addSubview(detailTextView)
        
        detailLabel.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: 5, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        detailTextView.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 5, paddingRight: 10, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
