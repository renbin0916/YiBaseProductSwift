//
//  Int+Y.swift
//  YiBaseProductSwift
//
//  Created by zero_rb on 2020/9/11.
//  Copyright © 2020 任斌. All rights reserved.
//

import Foundation
import CoreGraphics

extension Int {
    
    public func y_valueBetween(min: Int, max: Int) -> Int
    {
        switch self {
        case max...:
            return max
        case ...min:
            return min
        default:
            return self
        }
    }
    
    public var y_valueBetween0And1: Int {
        return self.y_valueBetween(min: 0, max: 1)
    }
    
    public var y_stringValue: String {
        return "\(self)"
    }
    
    public var y_floatValue: Float {
        return Float(self)
    }
    
    public var y_CGFloatValue: CGFloat {
        return CGFloat(self)
    }
    
    public var y_doubleValue: Double {
        return Double(self)
    }
    
    public var y_double: Int {
        return self * 2
    }
    
    public var y_half: Int {
        return self/2
    }
    
    public var y_triple: Int {
        return self * 3
    }
    
    public var y_one_third: Int {
        return self/3
    }
    
    public var y_quadruple: Int {
        return self * 4
    }
    
    public var y_quarter: Int {
        return self/4
    }
}

