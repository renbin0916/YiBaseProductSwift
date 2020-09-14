//
//  Named+Y.swift
//  YiBaseProductSwift
//
//  Created by 任斌 on 2020/8/19.
//  Copyright © 2020 任斌. All rights reserved.
//

import Foundation

protocol YNamed {}

extension YNamed {
    static var className: String {
        return "\(self)"
    }
}
