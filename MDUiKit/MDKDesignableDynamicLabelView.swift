//
//  MDKDesignableDynamicLabelView.swift
//  ROAR
//
//  Created by Taun Chapman on 05/23/18.
//  Copyright © 2018 Roar. All rights reserved.
//

import UIKit

/**
 Designable base class for design by intent labels
 
 Intents being: header, title, device name, location, ...
 
 Override assignTraits to change the font, type, size, color, ... for all subsclasses
 */

@IBDesignable
open class MDKDesignableDynamicLabelView: UILabel {
        
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupDefaults()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        setupDefaults()
    }
    
    open override func prepareForInterfaceBuilder() {
//        setupDefaults()
        setNeedsUpdateConstraints()
        layoutIfNeeded()
    }
    
    var contentSizeNotificationToken: NSObjectProtocol?
    
    func setupDefaults() {
        translatesAutoresizingMaskIntoConstraints = false
        
        handleContentSizeCategoryDidChange(notification: nil)
        
        contentSizeNotificationToken = NotificationCenter.default.addObserver(forName: UIContentSizeCategory.didChangeNotification, object: nil, queue: OperationQueue.main) { [weak self](notification) in
            self?.handleContentSizeCategoryDidChange(notification: notification)
        }
        setNeedsLayout()
        setNeedsUpdateConstraints()
    }
    
    public func assignTraits() {
        let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: UIFont.TextStyle.body)
        //        let shapeFontDescriptor = fontDescriptor.withSymbolicTraits(.traitItalic)
        let font = UIFont(descriptor: fontDescriptor, size: 0.0)
        self.font = font
    }
    
    // MARK: - Notifications
    func handleContentSizeCategoryDidChange(notification: Notification?) {
        assignTraits()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(contentSizeNotificationToken as Any)
    }
}
