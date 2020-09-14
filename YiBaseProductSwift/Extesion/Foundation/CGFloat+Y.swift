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
    static func valueBetween(min: CGFloat, max: CGFloat, percent: CGFloat) -> CGFloat {
        let usedPercent = percent.valueBetween0And1
        let diffrence   = max - min
        return min + diffrence * usedPercent
    }
    
    //MARK: instance method
    public func valueBetween(min: CGFloat, max: CGFloat) -> CGFloat
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
    
    public var valueBetween0And1: CGFloat {
        return self.valueBetween(min: 0, max: 1)
    }
    
    public var stringValue: String {
        return "\(self)"
    }
    
    public var intValue: Int {
        return Int(self)
    }
    
    public var floatValue: Float {
        return Float(self)
    }
    
    public var doubleValue: Double {
        return Double(self)
    }
    
    public var double: CGFloat {
        return self * 2.0
    }
    
    public var half: CGFloat {
        return self * 0.5
    }
    
    public var triple: CGFloat {
        return self * 3.0
    }
    
    public var one_third: CGFloat {
        return self/3.0
    }
    
    public var quadruple: CGFloat {
        return self * 4.0
    }
    
    public var quarter: CGFloat {
        return self * 0.25
    }
}

