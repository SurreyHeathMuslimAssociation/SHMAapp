//
//  WelcomeView+Datasource.swift
//  SHMA
//
//  Created by Umar Yaqub on 28/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

extension WelcomeView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! WelcomeViewCell
        cell.pageViewModel = pageViewModel[indexPath.item]
        cell.delegate = self
        return cell
    }
    
    
}
