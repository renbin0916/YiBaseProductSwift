//
//  String+Extension.swift
//  YiBaseProductSwift
//
//  Created by 任斌 on 2020/8/19.
//  Copyright © 2020 任斌. All rights reserved.
//

import Foundation
import CoreGraphics

// MARK: - const
extension String {
    public static let y_empty = ""
}

// MARK: - conversion
extension String {
    
    public var y_intValue: Int? {
        return Int(self)
    }
    
    public var y_floatValue: Float? {
        return Float(self)
    }
    
    public var y_CGFloatValue: CGFloat? {
        if let temp = y_doubleValue {
            return CGFloat(temp)
        }
        return nil
    }
    
    public var y_doubleValue: Double? {
        return Double(self)
    }
    
    public var y_urlValue: URL? {
        return URL(string: self)
    }
    
    public var y_boolValue: Bool? {
        let resultString   = lowercased()
        let trueTextArray  = ["true", "1", "yes"]
        let falseTextArray = ["false", "no", "0"]
        if trueTextArray.contains(resultString) {
            return true
        } else if falseTextArray.contains(resultString) {
            return false
        }
        return nil
    }
    
    public var y_dictValue: [String: Any]? {
        return self.data(using: .utf8)
            .flatMap { try? JSONSerialization.jsonObject(with: $0, options: .mutableContainers) as? [String: Any]}
    }
}

// MARK: - manipulate
extension String {
    public func y_filterSpaceAndNewLines() ->String {
        return components(separatedBy: .whitespacesAndNewlines).joined(separator: .y_empty)
    }
    
    public func y_isValidAccount() -> Bool {
        let regex = "^[a-zA-Z0-9]{6,16}$"
        let predicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    public func y_isValidQQ() -> Bool {
        let regex = "^[1-9][0-9]{4,12}$"
        let predicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    public func y_isValidChinaMobile() -> Bool {
        let regex = "^1\\d{10}$"
        let predicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    public func y_isValidEmail() -> Bool {
        let regex = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
        let predicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    public func y_isValidRealName() -> Bool {
        let regex = "^[\\u4e00-\\u9fa5]{2,5}$"
        let predicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    public func y_isPureChinese() -> Bool {
        let regex = "^[\\u4e00-\\u9fa5]+$"
        let predicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
}
