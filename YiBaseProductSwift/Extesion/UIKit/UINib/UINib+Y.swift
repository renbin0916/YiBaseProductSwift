//
//  UINib+Y.swift
//  YiBaseProductSwift
//
//  Created by 任斌 on 2020/8/19.
//  Copyright © 2020 任斌. All rights reserved.
//

import UIKit

protocol NibLoadable {}

extension NibLoadable {
    static func loadFromNib() -> Self {
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.first as! Self
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "\(self)", bundle: nil)
    }
}
