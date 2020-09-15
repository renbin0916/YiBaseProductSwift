//
//  Value+Y.swift
//  YiBaseProductSwift
//
//  Created by 任斌 on 2020/8/19.
//  Copyright © 2020 任斌. All rights reserved.
//

import Foundation
import CoreGraphics

extension CGFloat {
    
    //MARK: class method
    static func y_valueBetween(min: CGFloat, max: CGFloat, percent: CGFloat) -> CGFloat {
        let usedPercent = percent.y_valueBetween0And1
        let diffrence   = max - min
        return min + diffrence * usedPercent
    }
    
    //MARK: instance method
    public func y_valueBetween(min: CGFloat, max: CGFloat) -> CGFloat
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
    
    public var y_valueBetween0And1: CGFloat {
        return self.y_valueBetween(min: 0, max: 1)
    }
    
    public var y_stringValue: String {
        return "\(self)"
    }
    
    public var y_intValue: Int {
        return Int(self)
    }
    
    public var y_floatValue: Float {
        return Float(self)
    }
    
    public var y_doubleValue: Double {
        return Double(self)
    }
    
    public var y_double: CGFloat {
        return self * 2.0
    }
    
    public var y_half: CGFloat {
        return self * 0.5
    }
    
    public var y_triple: CGFloat {
        return self * 3.0
    }
    
    public var y_one_third: CGFloat {
        return self/3.0
    }
    
    public var y_quadruple: CGFloat {
        return self * 4.0
    }
    
    public var y_quarter: CGFloat {
        return self * 0.25
    }
}

