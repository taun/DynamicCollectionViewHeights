//
//  PrimaryDataSource.swift
//  DynamicCollectionViews
//
//  Created by Taun Chapman on 11/30/18.
//  Copyright © 2018 MOEDAE LLC. All rights reserved.
//

import UIKit

class PrimaryDataSource: NSObject, UICollectionViewDataSource {

    private let modelCollection: ModelCollection
    
    init(model: ModelCollection) {
        modelCollection = model
    }
    
    var desiredWidth: CGFloat = 100.0
    var desiredPadding: CGFloat = 10.0

    // MARK: - Standard UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let rows = modelCollection.count
        return rows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DynamicCollectionCell", for: indexPath)
        if let tileCell = cell as? DemoCollectionViewCell {
            tileCell.desiredWidth = desiredWidth
            tileCell.desiredPadding = desiredPadding
            tileCell.model = modelCollection[indexPath.row]
        }
        
        return cell
    }
}
