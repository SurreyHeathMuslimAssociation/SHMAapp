//
//  BusinessDetailView.swift
//  SHMA
//
//  Created by Umar Yaqub on 11/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

protocol BusinessDetailViewDelegate: class {
    func didTapGetDirections()
}
class BusinessDetailView: UITableView {
    
    let cellId = "cellId"
    let headerId = "headerId"
    let footerId = "footerId"
    var businessDetails: [String]!
    var businessLabels: [String]!
    var businessViewModel: BusinessViewModel?
    weak var businessDetailViewDelegate: BusinessDetailViewDelegate?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        backgroundColor = .white
        
        // set delegate and datasource
        delegate = self
        dataSource = self
        
        businessDetails = [String]()
        businessLabels = [String]()
        
        register(ProfileCell.self, forCellReuseIdentifier: cellId)
        register(BusinessDetailHeader.self, forHeaderFooterViewReuseIdentifier: headerId)
        register(ProfileFooter.self, forHeaderFooterViewReuseIdentifier: footerId)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
