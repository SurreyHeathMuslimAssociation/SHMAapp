//
//  FuneralContactsView.swift
//  SHMA
//
//  Created by Umar Yaqub on 16/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

class FuneralContactsView: UICollectionView {
    
    let cellId = "cellId"
    var funeralContactViewModel: FuneralContactViewModel!
    var funeralContactViewModels: [FuneralContactViewModel]?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        
        // conform to datasource delegate
        delegate = self
        dataSource = self
        
        funeralContactViewModels = [FuneralContactViewModel]()
        register(FuneralContactsCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
