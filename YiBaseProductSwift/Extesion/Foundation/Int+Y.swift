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
    
    public func valueBetween(min: Int, max: Int) -> Int
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
    
    public var valueBetween0And1: Int {
        return self.valueBetween(min: 0, max: 1)
    }
    
    public var stringValue: String {
        return "\(self)"
    }
    
    public var floatValue: Float {
        return Float(self)
    }
    
    public var CGFloatValue: CGFloat {
        return CGFloat(self)
    }
    
    public var doubleValue: Double {
        return Double(self)
    }
    
    public var double: Int {
        return self * 2
    }
    
    public var half: Int {
        return self/2
    }
    
    public var triple: Int {
        return self * 3
    }
    
    public var one_third: Int {
        return self/3
    }
    
    public var quadruple: Int {
        return self * 4
    }
    
    public var quarter: Int {
        return self/4
    }
}

