//
//  UIColor+Y.swift
//  YiBaseProductSwift
//
//  Created by 任斌 on 2020/8/19.
//  Copyright © 2020 任斌. All rights reserved.
//

import UIKit

extension UIColor {
    public static func y_colorFrom(beginColor: UIColor,
                                   endColor: UIColor,
                                   percent: CGFloat) -> UIColor
    {
        let usedPercent = percent.y_valueBetween0And1
        var red1: CGFloat = 1
        var red2: CGFloat = 1
        var green1: CGFloat = 1
        var green2: CGFloat = 1
        var blue1: CGFloat  = 1
        var blue2: CGFloat  = 1
        var alp1: CGFloat   = 1
        var alp2: CGFloat   = 1
        beginColor.getRed(&red1, green: &green1, blue: &blue1, alpha: &alp1)
        endColor.getRed(&red2, green: &green2, blue: &blue2, alpha: &alp2)
        
        let diffRed   = red2 - red1
        let diffGreen = green2 - green1
        let diffBlue  = blue2 - blue1
        let diffAlp   = alp2 - alp1
        
        let resultRed   = red1 + diffRed * usedPercent
        let resultGreen = green1 + diffGreen * usedPercent
        let resultBlue  = blue1 + diffBlue * usedPercent
        let resultAlp   = alp1 + diffAlp * usedPercent
        
        return UIColor(red: resultRed, green: resultGreen, blue: resultBlue, alpha: resultAlp)
    }
    
    public static func y_color(with red: Int,
                               green: Int,
                               blue: Int,
                               alpha: CGFloat = 1) -> UIColor
    {
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: alpha)
    }
    
    public static func y_colorWithHexString(_ colorString: String) -> UIColor? {
        var usedColor: UIColor?
        
        if colorString.count == 6 {
            var isRight = false
            let temp = colorString.uppercased()
            for charact in temp {
                if (charact >= "0" && charact <= "9") {
                    isRight = true
                } else if (charact >= "A" && charact <= "F") {
                    isRight = true
                }
            }
            if isRight {
                let red1 = temp[temp.startIndex]
                let red2 = temp[temp.index(after: temp.startIndex)]
                
                let green1 = temp[temp.index(temp.startIndex, offsetBy: 2)]
                let green2 = temp[temp.index(temp.startIndex, offsetBy: 3)]
                
                let blue1  = temp[temp.index(temp.startIndex, offsetBy: 4)]
                let blue2  = temp[temp.index(temp.startIndex, offsetBy: 5)]
                
                let r = red1._toInt() * 16 + red2._toInt()
                let g = green1._toInt() * 16 + green2._toInt()
                let b = blue1._toInt() * 16 + blue2._toInt()
                
                usedColor = UIColor.y_color(with: r, green: g, blue: b)
            }
        }
        return usedColor
    }
    
    public static var y_randomColor: UIColor {
        let red   = Int(arc4random() % 256)
        let green = Int(arc4random() % 256)
        let blue  = Int(arc4random() % 256)
        return UIColor.y_color(with: red, green: green, blue: blue)
    }
}

extension Character {
    fileprivate func _toInt() -> Int {
        if self == "A" {
            return 10
        } else if self == "B" {
            return 11
        } else if self == "C" {
            return 12
        } else if self == "D" {
            return 13
        } else if self == "E" {
            return 14
        } else if self == "F" {
            return 15
        }
        return Int(String(self)) ?? 0
    }
}
