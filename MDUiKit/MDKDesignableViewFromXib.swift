//
//  MDKDesignableViewFromXib.swift
//  MDUiKit
//
//  Created by Taun Chapman on  09/24/14.
//  Copyright (c) 2014 MOEDAE LLC. All rights reserved.
//

import UIKit

/**
 Specialized view for loading from a Xib.
 
 * Designable allows it to show up as a real rendered view in a storyboard.
 
 * Auto-loading from same named Xib allows visual layout of view and reuse.
 
 ** How to use: **
 
 * Create a Xib for the desired model view.
 
 * Create a Swift file subclass of this class and give it the **same name** as the xib.
 
 * Link the Xib's File's Owner to the new subclass.
 
 * The Xib root view becomes the File's Owner .view property
 
 * The root view in the Xib should not be a custom view, just a container.
 
 * You can add an edge to edge MDKLayerViewDesignable for rounded corners, gradients, etc.
 
 * Use custom design intent labels for the parts of the model view. Design intent meaning: Title, description, device name, ...
 */

@IBDesignable
open class MDKDesignableViewFromXib: UIView {
    var view: UIView!
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }
    
    class var NibName: String {
        return String(describing: self)
    }
    
    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: type(of: self).NibName, bundle: bundle)
        if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            view.frame = bounds
            //        view.autoresizingMask = [
            //            UIView.AutoresizingMask.flexibleWidth,
            //            UIView.AutoresizingMask.flexibleHeight
            //        ]
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            
            self.view = view
        }
    }
}
