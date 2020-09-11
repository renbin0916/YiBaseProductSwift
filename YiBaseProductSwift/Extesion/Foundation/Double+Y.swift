
//
//  Double+Y.swift
//  YiBaseProductSwift
//
//  Created by zero_rb on 2020/9/11.
//  Copyright © 2020 任斌. All rights reserved.
//

import Foundation
import CoreGraphics

extension Double {
    
    public func valueBetween(min: Double, max: Double) -> Double
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
    
    public var valueBetween0And1: Double {
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
    
    public var floatValue: Float {
        return Float(self)
    }
    
    public var double: Double {
        return self * 2.0
    }
    
    public var half: Double {
        return self * 0.5
    }
    
    public var triple: Double {
        return self * 3.0
    }
    
    public var one_third: Double {
        return self/3.0
    }
    
    public var quadruple: Double {
        return self * 4.0
    }
    
    public var quarter: Double {
        return self * 0.25
    }
}

