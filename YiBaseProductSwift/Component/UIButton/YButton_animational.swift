//
//  YButton_animational.swift
//  YiBaseProductSwift
//
//  Created by zero_rb on 2020/9/11.
//  Copyright © 2020 任斌. All rights reserved.
//

import UIKit

/*
 * this button will have a animation when you change it's text color
 */
public class YButton_animational: UIView {
    
    //MARK: public
    public typealias ButtonClickBlock = (_ button: YButton_animational) ->Void
    public var clickButton: ButtonClickBlock?
    public var highlightColor: UIColor?
    /// if we want a font animation with color change, this property should be set value to true
    public var shouldChangeTextFont = false
    /// if we make shouldChangeTextFont == true, this property value will decide how bigger the text could be
    public var maxScale: CGFloat    = 1
    public var title: String = "" {
        didSet {
            _textLayer.string = title
        }
    }
    
    public var normalColor: UIColor = .black {
        didSet {
            if !isSelected {
                _textLayer.foregroundColor = normalColor.cgColor
            }
        }
    }
    
    public var selectedColor: UIColor = .blue {
        didSet {
            if isSelected {
                _textLayer.foregroundColor = selectedColor.cgColor
            }
        }
    }
    
    public var font:UIFont = .systemFont(ofSize: 18) {
        didSet {
            _textLayer.font     = font
            _textLayer.fontSize = font.pointSize
        }
    }
    
    public var percent: CGFloat = 0 {
        didSet {
            _textLayer.foregroundColor = UIColor.colorFrom(beginColor: normalColor,
                                                           endColor: selectedColor,
                                                           percent: percent).cgColor
        }
    }
    
    public var isSelected: Bool = false {
        didSet {
            let temp = isSelected ? selectedColor : normalColor
            UIView.animate(withDuration: .animateTime_show) {
                self._textLayer.foregroundColor = temp.cgColor
            }
        }
    }
    
    convenience init(_ titleI: String,
                     normalColorI: UIColor,
                     selectedColorI: UIColor,
                     fontI: UIFont = UIFont.systemFont(ofSize: 18),
                     percentI: CGFloat = 0,
                     isSelectedI: Bool = false) {
        self.init()
        title = titleI
        normalColor   = normalColorI
        selectedColor = selectedColorI
        font          = fontI
        percent       = percentI
        isSelected    = isSelectedI
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        _textLayer.frame = self.bounds
    }
    
    
    //MARK: actions
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let usedC = highlightColor {
            UIView.animate(withDuration: .animateTime_show) {
                self._textLayer.foregroundColor = usedC.cgColor;
            }
        }
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        let usedC = isSelected ? selectedColor.cgColor : normalColor.cgColor
        UIView.animate(withDuration: .animateTime_hide) {
            self._textLayer.foregroundColor = usedC
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if let tap = touches.first?.tapCount, tap == 1 {
            clickButton?(self)
        }
    }
    
    
    //MARK: lazy load
    lazy var _textLayer: CATextLayer = {
        let temp = CATextLayer()
        temp.alignmentMode = .center
        temp.contentsScale = UIScreen.main.scale
        temp.font          = font
        temp.fontSize      = font.pointSize
        layer.addSublayer(temp)
        return temp
    }()
}
