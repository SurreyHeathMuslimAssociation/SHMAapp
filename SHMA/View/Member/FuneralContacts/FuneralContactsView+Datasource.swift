//
//  FuneralContactsView+Datasource.swift
//  SHMA
//
//  Created by Umar Yaqub on 16/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

extension FuneralContactsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return funeralContactViewModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FuneralContactsCell
        cell.funeralContactViewModel = funeralContactViewModels?[indexPath.item]
        return cell
    }
    
}
