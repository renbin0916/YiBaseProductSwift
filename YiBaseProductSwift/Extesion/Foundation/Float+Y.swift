//
//  Float+Y.swift
//  YiBaseProductSwift
//
//  Created by zero_rb on 2020/9/11.
//  Copyright © 2020 任斌. All rights reserved.
//

import Foundation
import CoreGraphics

extension Float {
    
    public func valueBetween(min: Float, max: Float) -> Float
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
    
    public var valueBetween0And1: Float {
        return self.valueBetween(min: 0, max: 1)
    }
    
    public var stringValue: String {
        return "\(self)"
    }
    
    public var intValue: Int {
        return Int(self)
    }
    
    public var CGFloatValue: CGFloat {
        return CGFloat(self)
    }
    
    public var doubleValue: Double {
        return Double(self)
    }
    
    public var double: Float {
        return self * 2.0
    }
    
    public var half: Float {
        return self * 0.5
    }
    
    public var triple: Float {
        return self * 3.0
    }
    
    public var one_third: Float {
        return self/3.0
    }
    
    public var quadruple: Float {
        return self * 4.0
    }
    
    public var quarter: Float {
        return self * 0.25
    }
}

