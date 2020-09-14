//
//  QuantumValue.swift
//  YiBaseProductSwift
//
//  Created by zero_rb on 2020/9/11.
//  Copyright © 2020 任斌. All rights reserved.
//

import Foundation

public enum YQuantumValue: Codable {
    
    case int(Int)
    case double(Double)
    case string(String)
    case bool(Bool)
    case null
    
    private enum CodingKeys: CodingKey {
        case int
        case double
        case string
        case bool
        case null
    }
    
    public init(from decoder: Decoder) throws {
        if let stringValue = try? decoder.singleValueContainer().decode(String.self) {
            if let boolValue = stringValue.boolValue {
                self = .bool(boolValue)
            } else {
                self = .string(stringValue)
            }
        } else if let intValue = try? decoder.singleValueContainer().decode(Int.self) {
            self = .int(intValue)
        } else if let doubleValue = try? decoder.singleValueContainer().decode(Double.self) {
            self = .double(doubleValue)
        } else if let boolValue = try? decoder.singleValueContainer().decode(Bool.self) {
            self = .bool(boolValue)
        } else {
            self = .null
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .int(let value):
            try container.encode(value, forKey: .int)
        case .double(let value):
            try container.encode(value, forKey: .double)
        case .string(let value):
            try container.encode(value, forKey: .string)
        case .bool(let value):
            try container.encode(value, forKey: .bool)
        case .null:
            break
        }
    }
}

extension YQuantumValue {
    public var value: Any? {
        switch self {
        case .int(let value):
            return value
        case .double(let value):
            return value
        case .string(let value):
            return value
        case .bool(let value):
            return value
        case .null:
            return nil
        }
    }

    public var intValue: Int? {
        switch self {
        case .int(let value):
            return value
        default:
            return nil
        }
    }

    public var doubleValue: Double? {
        switch self {
        case .double(let value):
            return value
        default:
            return nil
        }
    }

    public var boolValue: Bool? {
        switch self {
        case .bool(let value):
            return value
        default:
            return nil
        }
    }

    public var stringValue: String? {
        switch self {
        case .string(let value):
            return value
        default:
            return nil
        }
    }

    public var isNull: Bool {
        switch self {
        case .null:
            return true
        default:
            return false
        }
    }
}
