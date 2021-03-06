//
//  YLoadDataProtocol.swift
//  YiBaseProductSwift
//
//  Created by zero_rb on 2020/9/14.
//  Copyright © 2020 任斌. All rights reserved.
//

import Foundation

public protocol YLoadDataProtocol {
    associatedtype DataType
    func loadData(data: DataType, isSelected: Bool)
}
