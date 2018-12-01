//
//  DemoCollectionViewCell.swift
//  DynamicCollectionViews
//
//  Created by Taun Chapman on 11/30/18.
//  Copyright © 2018 MOEDAE LLC. All rights reserved.
//

import UIKit
import os.log

class DemoCollectionViewCell: UICollectionViewCell {
    
    var containerView: MDKLayerViewDesignable?
    var internalView: LabelView?

    
    let internalViewType: LabelView.Type? = LabelView.self // LabelView.Type? should be UIView.Type and a protocol which takes a LabelModel
        
    public var model: LabelModel? {
        didSet {
            setupInternalView()
        }
    }
    
    public var desiredWidth: CGFloat = 100.0
//    {
//        didSet {
//            widthLayoutContraint?.constant = calculateCellWidthFor(width: desiredWidth, padding: desiredPadding)
//            setNeedsUpdateConstraints()
//        }
//    }
    public var desiredPadding: CGFloat = 3.0

    func calculateCellWidthFor(width: CGFloat, padding: CGFloat) -> CGFloat {
        return (width - (2 * padding))
    }

    private var widthLayoutContraint: NSLayoutConstraint?
    
    fileprivate func setupContainerView() {
        
        guard containerView == nil else {
            return
        }
        
        containerView = MDKLayerViewDesignable(frame: bounds)
        if let containerView = containerView {
            let padding:CGFloat = 0.0
            
            containerView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(containerView)
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding).isActive = true
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding).isActive = true
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            
            clipsToBounds = false
            containerView.backgroundColor = UIColor.blue
            containerView.borderColor = UIColor.blue
            containerView.borderWidth = 1.0
            containerView.cornerRadius = 6.0
            containerView.shadowColor = nil
            containerView.shadowOffset = CGSize(width: 0.0, height: 0.0)
            containerView.shadowRadius = 0.0
            containerView.shadowOpacity = 0.0
            containerView.maskToBounds = true
            containerView.setContentHuggingPriority(UILayoutPriority.required, for: .vertical)
            contentView.setContentHuggingPriority(UILayoutPriority.required, for: .vertical)
            setContentHuggingPriority(UILayoutPriority.required, for: .vertical)
        }
    }
    
    fileprivate func setupInternalView() {
        setupContainerView()
        
        if let containerView = containerView {
            internalView = internalViewType?.init(frame: CGRect.zero)
            
            guard let internalView = internalView else { return }
            
            containerView.addSubview(internalView)
            internalView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
            internalView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
            internalView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
            internalView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
            
            widthLayoutContraint = NSLayoutConstraint(item: internalView,
                               attribute: .width,
                               relatedBy: .equal,
                               toItem: nil,
                               attribute: .notAnAttribute,
                               multiplier: 1.0,
                               constant: calculateCellWidthFor(width: desiredWidth, padding: desiredPadding))
            widthLayoutContraint?.isActive = true
            
            internalView.model = model
            internalView.setContentHuggingPriority(UILayoutPriority.required, for: .vertical)
        }
    }
    
    override func prepareForReuse() {
        if containerView != nil {
            for subView in containerView!.subviews{
                subView.removeFromSuperview()
            }
        }
        
        containerView?.removeFromSuperview()
        containerView = nil
        
        defer {
            internalView?.removeFromSuperview()
            internalView = nil
            model = nil
            NotificationCenter.default.removeObserver(self, name: UIContentSizeCategory.didChangeNotification, object: nil)
        }
        
//        guard let tileView = tileView as? (UIView & TileViewProtocol) else { return }
        
        internalView?.model = nil
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        os_log("CellDebug %@ %@", type: .debug, String(describing: type(of: self)), #function)
    }
    
    public override func updateConstraints() {
        internalView?.updateConstraints()
        containerView?.updateConstraints()
        super.updateConstraints()
        os_log("CellDebug %@ %@", type: .debug, String(describing: type(of: self)), #function)
    }
    
}
