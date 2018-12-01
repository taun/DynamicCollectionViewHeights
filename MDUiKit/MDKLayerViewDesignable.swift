//
//  MDKLayerViewDesignable.swift
//  MDUiKit
//
//  Created by Taun Chapman on 09/24/14.
//  Copyright (c) 2014 MOEDAE LLC. All rights reserved.
//
import UIKit

@IBDesignable open class MDKLayerViewDesignable: UIView {
    
    // Sample setting to standard defaults
    open func setDefaultProperties() {
        margin = 0
        gradientStartColor = nil
        gradientStopColor = nil
        gradientAngle = 0.0
        cornerRadius = 0
        borderColor = nil
        borderWidth = 0
        shadowOffset = CGSize(width: 0, height: 0)
        shadowColor = nil
        shadowRadius = 0
        shadowOpacity = 0
        maskToBounds = false
        backgroundImage = nil
    }

    @IBInspectable var maskToBounds: Bool = false {
        didSet {
            if oldValue != maskToBounds {
                layer.masksToBounds = maskToBounds
                setNeedsDisplay()
            }
        }
    }
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            if oldValue != cornerRadius {
                layer.cornerRadius = cornerRadius
                setNeedsDisplay()
            }
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            if oldValue != borderWidth {
                layer.borderWidth = borderWidth
                setNeedsDisplay()
            }
        }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet {
            if oldValue != borderColor {
                layer.borderColor = borderColor?.cgColor
                setNeedsDisplay()
            }
        }
    }
    @IBInspectable var shadowOffset: CGSize = CGSize() {
        didSet {
            if oldValue != shadowOffset {
                layer.shadowOffset = shadowOffset
                setNeedsDisplay()
            }
        }
    }
    @IBInspectable var shadowColor: UIColor? {
        didSet {
            if oldValue != shadowColor {
                layer.shadowColor = shadowColor?.cgColor
                setNeedsDisplay()
            }
        }
    }
    @IBInspectable var shadowOpacity: Float = 0.0 {
        didSet {
            if oldValue != shadowOpacity {
                layer.shadowOpacity = shadowOpacity
                setNeedsDisplay()
            }
        }
    }
    @IBInspectable var shadowRadius: CGFloat = 0.0 {
        didSet {
            if oldValue != shadowRadius {
                layer.shadowRadius = shadowRadius
                setNeedsDisplay()
            }
        }
    }
    @IBInspectable var margin: CGFloat = 0.0 {
        didSet {
            if oldValue != margin {
                setNeedsDisplay()
            }
        }
    }
    @IBInspectable var gradientStartColor: UIColor? {
        didSet {
            if oldValue != gradientStartColor {
                setNeedsDisplay()
            }
        }
    }
    @IBInspectable var gradientStopColor: UIColor? {
        didSet {
            if oldValue != gradientStopColor {
                setNeedsDisplay()
            }
        }
    }
    
    @IBInspectable var gradientAngle: CGFloat = 0.0 {
        didSet {
            if oldValue != gradientAngle {
                setNeedsDisplay()
            }
        }
    }

    @IBInspectable var backgroundImage: UIImage? {
        didSet {
            if oldValue != backgroundImage {
                if backgroundImage != nil {
                    setupImageLayer()
                } else {
                    if imageLayer != nil {
                        imageLayer?.removeFromSuperlayer()
                        imageLayer = nil
                    }
                }
                updateLayerProperties()
                setNeedsDisplay()
            }
        }
    }
    
    @IBInspectable var imageLayer: CALayer?

//    @IBInspectable var styleKitClass: String?
//    @IBInspectable var styleKitImageMethod: String?

    override open class var layerClass : AnyClass {
        return CALayer.self
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setDefaultProperties()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setDefaultProperties()
    }
    
    override open func prepareForInterfaceBuilder() {
        updateLayerProperties()
        setNeedsDisplay()
    }
    
    func setupImageLayer() {
        if imageLayer == nil {
            imageLayer = CALayer()
            guard imageLayer != nil else {
                return
            }
            layer.addSublayer(imageLayer!)
            imageLayer?.contentsGravity = CALayerContentsGravity.resize
            imageLayer?.isOpaque = false
        }
    }
    
    override open func layoutSubviews() {
        updateLayerProperties()
        super.layoutSubviews()
    }
    
    func updateLayerProperties() {
        layer.frame = layer.frame.insetBy(dx: margin, dy: margin)

        if let startColor = gradientStartColor?.cgColor, let stopColor = gradientStopColor?.cgColor  {
            let gradientLayer = CAGradientLayer()
            layer.addSublayer(gradientLayer)
            gradientLayer.colors = [startColor, stopColor]
            gradientLayer.transform = CATransform3DMakeRotation(CGFloat.pi * gradientAngle/180.0, 0, 0, 1)
            gradientLayer.frame = layer.bounds
        }
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColor?.cgColor
        layer.borderWidth = borderWidth
        layer.shadowOffset = shadowOffset
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.masksToBounds = maskToBounds

        imageLayer?.contents = backgroundImage?.cgImage
    }
}
