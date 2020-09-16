

//
//  UIView+Y.swift
//  YiBaseProductSwift
//
//  Created by 任斌 on 2020/8/19.
//  Copyright © 2020 任斌. All rights reserved.
//

import UIKit

extension UIView: YNamed {}

//MARK: frame
extension UIView {
    public var y_x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            var newFrame = frame
            newFrame.origin.x = newValue
            frame = newFrame
        }
    }
    
    public var y_y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            var newFrame = frame
            newFrame.origin.y = newValue
            frame = newFrame
        }
    }
    
    public var y_width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            var newFrame = frame
            newFrame.size.width = newValue
            frame = newFrame
        }
    }
    
    public var y_height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            var newFrame = frame
            newFrame.size.height = newValue
            frame  = newFrame
        }
    }
    
    public var y_centerX: CGFloat {
        get {
            return center.x
        }
        set {
            var newCenter = center
            newCenter.x   = newValue
            center  = newCenter
        }
    }
    
    public var y_centerY: CGFloat {
        get {
            return center.y
        }
        set {
            var newCenter = center
            newCenter.y   = newValue
            center = newCenter
        }
    }
}

//MARK: XIB
extension UIView {
    @IBInspectable var y_cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            clipsToBounds      = true
        }
    }
        
    @IBInspectable var y_borderColor: UIColor? {
        get {
            guard let bColor = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: bColor)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var y_borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var y_shadowColor: UIColor? {
        get {
            guard let color = layer.shadowColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var y_shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var y_shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var y_shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
}

//MARK: rotation
extension UIView {
    public func y_startRotate() {
        let animate = CABasicAnimation(keyPath: "transform.rotation.z")
        animate.toValue  = NSNumber(value: Double.pi * 2.0)
        animate.duration = 0.6
        animate.isCumulative = true
        animate.repeatCount  = MAXFLOAT
        layer.add(animate, forKey: "rotationAnimate")
    }
    
    public func y_stopRotate() {
        layer.removeAnimation(forKey: "rotationAnimate")
    }
}

//MARK: to image
extension UIView {
    public func y_toImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0)
        if self.drawHierarchy(in: self.bounds, afterScreenUpdates: true) {
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
        return nil
    }
}

//MARK: UIViewcontroller
extension UIView {
    public func y_parentVC() -> UIViewController? {
        var temp: UIView? = self
        while temp != nil {
            if temp?.next?.isKind(of: UIViewController.classForCoder()) ?? false {
                return temp?.next as? UIViewController
            } else {
                temp = temp?.superview
            }
        }
        return nil
    }
}

//MARK: gradient layer
extension UIView {
    private struct AssociateKeys {
        static var gradientLayerKey = "y_gradientLayerKey"
    }
    
    public var y_grandientLayer: CAGradientLayer? {
        get {
            var temp = objc_getAssociatedObject(self, &AssociateKeys.gradientLayerKey) as? CAGradientLayer
            if temp == nil {
                temp = CAGradientLayer()
                self.y_grandientLayer = temp
            }
            return temp
        }
        set {
            y_removeGrandientLayer()
            if let exist = newValue {
                exist.name = AssociateKeys.gradientLayerKey
                layer.insertSublayer(exist, at: 0)
            }
            objc_setAssociatedObject(self, &AssociateKeys.gradientLayerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public func y_updateGradientlayerHorizontal(beginColor: UIColor,
                                                endColor: UIColor) {
        y_updateGrandLayer(beginColor: beginColor,
                           endColor: endColor,
                           startPoint: .zero,
                           endPoint: CGPoint(x: 1, y: 0))
    }
    
    public func y_updateGradientLayerVertical(beginColor: UIColor,
                                              endColor: UIColor) {
        y_updateGrandLayer(beginColor: beginColor,
                           endColor: endColor,
                           startPoint: .zero,
                           endPoint: CGPoint(x: 0, y: 1))
    }
    
    public func y_updateGrandLayer(beginColor: UIColor,
                                   endColor: UIColor,
                                   startPoint: CGPoint,
                                   endPoint: CGPoint) {
        let colors = [beginColor.cgColor, endColor.cgColor]
        y_grandientLayer?.startPoint = startPoint
        y_grandientLayer?.endPoint   = endPoint
        y_grandientLayer?.colors     = colors
        y_grandientLayer?.frame      = bounds
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    public func y_removeGrandientLayer() {
        guard let layers = layer.sublayers else { return }
        for item in layers {
            if item.name == AssociateKeys.gradientLayerKey {
                item.removeFromSuperlayer()
                return
            }
        }
    }
}
