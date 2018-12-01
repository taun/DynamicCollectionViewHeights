//
//  LabelView.swift
//  Taun
//
//  Created by Taun Chapman on 11/30/18.
//  Copyright © 2018 Taun Chapman. All rights reserved.
//

import UIKit

class LabelView: MDKDesignableViewFromXib {
    
    var model: LabelModel? {
        didSet {
            updateProperties()
        }
    }
    
    @IBOutlet weak var modelLabel: UILabel!
    

    override required init(frame: CGRect) {
        super.init(frame: frame)
        setupProperties()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForInterfaceBuilder() {
        //set properties to what you want to see in IB view
        if modelLabel != nil {
            modelLabel.text = "Placeholder InterfaceBuilder text"
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupProperties()

        // If we awake from nib, there are prepopulated values in the output labels used for visual sizing.
        // Erase the placeholder text.
    }

    func setupProperties(){
        
        self.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        updateProperties()
    }

    func updateProperties() {
        modelLabel.text = model?.theString
    }

}
