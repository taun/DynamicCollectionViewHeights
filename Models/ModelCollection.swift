//
//  ModelCollection.swift
//  DynamicCollectionViews
//
//  Created by Taun Chapman on 11/30/18.
//  Copyright © 2018 MOEDAE LLC. All rights reserved.
//

import Foundation

class ModelCollection: NSObject {
    
    private(set) var models = [LabelModel]()
    
    func add(model: LabelModel) {
        models.append(model)
    }
        
    func populateDemo(count: Int) {
        for _ in 1...count {
            add(model: LabelModel(label: generateRandomLengthLabel()))
        }
    }
    
    private func generateRandomLengthLabel() -> String {
        var randomLengthString: String = ""
        let word = "ipsem "
        
        let words = Int.random(in: 1..<20)
        
        for _ in 1...words {
            randomLengthString.append(word)
        }
        
        return randomLengthString
    }
}

extension ModelCollection: Collection {
    func index(after i: Int) -> Int {
        return i + 1
    }
    
    subscript(position: Int) -> LabelModel {
        return models[position]
    }
    
    typealias Element = LabelModel
    
    typealias Index = Int
    
    var startIndex: Index { return models.startIndex }
    var endIndex: Index { return models.endIndex }
}
