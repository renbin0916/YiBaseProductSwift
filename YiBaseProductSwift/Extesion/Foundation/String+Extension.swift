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
    public static let empty = ""
}

// MARK: - conversion
extension String {

    public var intValue: Int? {
        return Int(self)
    }
    
    public var floatValue: Float? {
        return Float(self)
    }
    
    public var CGFloatValue: CGFloat? {
        if let temp = doubleValue {
            return CGFloat(temp)
        }
        return nil
    }
    
    public var doubleValue: Double? {
        return Double(self)
    }
    
    public var urlValue: URL? {
        return URL(string: self)
    }
    
    public var boolValue: Bool? {
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
    
    public var dictValue: [String: Any]? {
        return self.data(using: .utf8)
                   .flatMap { try? JSONSerialization.jsonObject(with: $0, options: .mutableContainers) as? [String: Any]}
    }
}

// MARK: - manipulate
extension String {
    public func filterSpaceAndNewLines() ->String {
        return components(separatedBy: .whitespacesAndNewlines).joined(separator: .empty)
    }
    
    public func isValidAccount() -> Bool {
        let regex = "^[a-zA-Z0-9]{6,16}$"
        let predicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    public func isValidQQ() -> Bool {
        let regex = "^[1-9][0-9]{4,12}$"
        let predicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    public func isValidChinaMobile() -> Bool {
        let regex = "^1\\d{10}$"
        let predicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    public func isValidEmail() -> Bool {
        let regex = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
        let predicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    public func isValidRealName() -> Bool {
        let regex = "^[\\u4e00-\\u9fa5]{2,5}$"
        let predicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    public func isPureChinese() -> Bool {
        let regex = "^[\\u4e00-\\u9fa5]+$"
        let predicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
}
