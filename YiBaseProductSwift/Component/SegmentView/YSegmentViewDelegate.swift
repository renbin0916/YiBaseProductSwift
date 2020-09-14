
//
//  YSegmentViewDelegate.swift
//  YiBaseProductSwift
//
//  Created by zero_rb on 2020/9/14.
//  Copyright © 2020 任斌. All rights reserved.
//

import UIKit

public protocol YSegmentViewDelegate: NSObjectProtocol {
    func segmentViewDidSelected(_ segmentView: UIView, index: Int)
    func segmentViewExclueIndexs(_ segmentView: UIView) -> [Int]
    func segmentViewExclueIndexWillSelected(_ segmentView: UIView, index: Int)
}

extension YSegmentViewDelegate {
    func segmentViewDidSelected(_ segmentView: UIView, index: Int) {}
    func segmentViewExclueIndexs(_ segmentView: UIView) -> [Int] { return [] }
    func segmentViewExclueIndexWillSelected(_ segmentView: UIView, _ index: Int) {}
}
