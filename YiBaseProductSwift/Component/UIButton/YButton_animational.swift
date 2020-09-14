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
    
    class func create(_ title: String,
                      normalColor: UIColor,
                      selectedColor: UIColor,
                      font: UIFont = UIFont.systemFont(ofSize: 18),
                      isSelecated: Bool = false) -> YButton_animational {
        let btn = YButton_animational()
        btn.title = title
        btn.normalColor = normalColor
        btn.selectedColor = selectedColor
        btn.font          = font
        btn.isSelected    = isSelecated
        return btn
    }
    
    //MARK: public
    public typealias ButtonClickBlock = (_ button: YButton_animational) ->Void
    public var clickButton: ButtonClickBlock?
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
            _originFont         = font
        }
    }
    
    public var percent: CGFloat = 0 {
        didSet {
            _textLayer.foregroundColor = UIColor.colorFrom(beginColor: normalColor,
                                                           endColor: selectedColor,
                                                           percent: percent).cgColor
            if shouldChangeTextFont {
                guard let originFont = _originFont else { return }
                let uesedSize = originFont.pointSize * ((maxScale - 1) * percent + 1)
                let usedfont  = originFont.withSize(uesedSize)
                _updateTextFont(usedFont: usedfont)
            }
        }
    }
    
    public var isSelected: Bool = false {
        didSet {
            let temp = isSelected ? selectedColor : normalColor
            if shouldChangeTextFont, let originFont = _originFont {
                let fontSize = isSelected ? originFont.pointSize * maxScale : originFont.pointSize
                UIView.animate(withDuration: .animateTime_show) {
                    self._textLayer.foregroundColor = temp.cgColor
                    self._textLayer.fontSize        = fontSize
                }
            } else {
                UIView.animate(withDuration: .animateTime_show) {
                    self._textLayer.foregroundColor = temp.cgColor
                }
            }
        }
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        _textLayer.frame = self.bounds
    }
    
    //MARK: actions
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if let tap = touches.first?.tapCount, tap == 1 {
            clickButton?(self)
        }
    }
    
    //MARK: private func
    private func _updateTextFont(usedFont: UIFont) {
        _textLayer.font     = usedFont
        _textLayer.fontSize = usedFont.pointSize
    }
    
    //MARK: lazy load
    lazy var _textLayer: CATextLayer_center = {
        let temp = CATextLayer_center()
        temp.alignmentMode = .center
        temp.contentsScale = UIScreen.main.scale
        temp.font          = font
        temp.fontSize      = font.pointSize
        layer.addSublayer(temp)
        temp.frame         = layer.bounds
        return temp
    }()
    
    //MARK: private property
    private var _originFont: UIFont?
}
