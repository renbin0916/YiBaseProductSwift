
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
    
    //MARK: class method
    static func y_valueBetween(min: Double, max: Double, percent: Double) -> Double {
        let usedPercent = percent.y_valueBetween0And1
        let diffrence   = max - min
        return min + diffrence * usedPercent
    }
    
    //MARK: instance method
    public func y_valueBetween(min: Double, max: Double) -> Double
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
    
    public var y_valueBetween0And1: Double {
        return self.y_valueBetween(min: 0, max: 1)
    }
    
    public var y_stringValue: String {
        return "\(self)"
    }
    
    public var y_intValue: Int {
        return Int(self)
    }
    
    public var y_CGFloatValue: CGFloat {
        return CGFloat(self)
    }
    
    public var y_floatValue: Float {
        return Float(self)
    }
    
    public var y_double: Double {
        return self * 2.0
    }
    
    public var y_half: Double {
        return self * 0.5
    }
    
    public var y_triple: Double {
        return self * 3.0
    }
    
    public var y_one_third: Double {
        return self/3.0
    }
    
    public var y_quadruple: Double {
        return self * 4.0
    }
    
    public var y_quarter: Double {
        return self * 0.25
    }
}

