//
//  LabelModel.swift
//  DynamicCollectionViews
//
//  Created by Taun Chapman on 11/30/18.
//  Copyright © 2018 MOEDAE LLC. All rights reserved.
//

import Foundation

class LabelModel: NSObject {
    static let DefaultString: String = "Empty"
    
    var theString: String?
    
    init(label: String) {
        theString = label
    }
}
