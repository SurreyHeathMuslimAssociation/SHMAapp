//
//  BusinessView.swift
//  SHMA
//
//  Created by Umar Yaqub on 07/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

protocol BusinessViewDelegate: class {
    func didTapCell(businessViewModel: BusinessViewModel)
}
class BusinessView: UICollectionView {
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let iv = UIActivityIndicatorView(style: .gray)
        return iv
    }()
    
    var businessViewModel: BusinessViewModel!
    var businessViewModels: [BusinessViewModel]!
    let cellId = "cellId"
    weak var businessViewDelegate: BusinessViewDelegate?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        
        // setting delegate and datasource
        delegate = self
        dataSource = self
        
        businessViewModels = [BusinessViewModel]()
        register(BusinessCell.self, forCellWithReuseIdentifier: cellId)
        
        setupActivityIndicatorView()
    }
    
    private func setupActivityIndicatorView() {
        addSubview(activityIndicatorView)
        activityIndicatorView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: centerYAnchor, centerXAnchor: centerXAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
