
//
//  Array.swift
//  YiBaseProductSwift
//
//  Created by zero_rb on 2020/9/15.
//  Copyright © 2020 任斌. All rights reserved.
//

import Foundation

extension Array {
    public subscript (y_safe index: Int) -> Element? {
        return (0..<count).contains(index) ? self[index] : nil
    }
}

extension NSArray {
    public subscript (y_safe index: Int) -> Element? {
        return (0..<count).contains(index) ? self[index] : nil
    }
}
