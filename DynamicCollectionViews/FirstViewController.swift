//
//  FirstViewController.swift
//  DynamicCollectionViews
//
//  Created by Taun Chapman on 11/30/18.
//  Copyright © 2018 MOEDAE LLC. All rights reserved.
//

import UIKit

class FirstViewController: UICollectionViewController {

    private lazy var modelCollection: ModelCollection = {
        let tempModel = ModelCollection()
        tempModel.populateDemo(count: 120)
        return tempModel
    }()
    
    private lazy var dataSource = PrimaryDataSource(model: modelCollection)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        dataSource.desiredWidth = collectionView.bounds.size.width
        dataSource.desiredPadding = 2.0
        collectionView.dataSource = dataSource
    }

    // MARK: - Standard UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if let cell = cell as? DemoCollectionViewCell {
//            cell.desiredWidth = collectionView.bounds.size.width
//            cell.desiredPadding = 3.0
//        }
    }
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? DemoCollectionViewCell {
            cell.model = nil
        }
    }
}

