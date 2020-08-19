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
}
