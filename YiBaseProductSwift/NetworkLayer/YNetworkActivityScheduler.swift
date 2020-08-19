//
//  YNetworkActivityScheduler.swift
//  YiBaseProductSwift
//
//  Created by 任斌 on 2020/8/19.
//  Copyright © 2020 任斌. All rights reserved.
//

import Foundation
import UIKit

final public class YNetworkActivityScheduler {
    //MARK: init
    static let shared = YNetworkActivityScheduler()
    private init() {}
    
    //MARK: pubilc func
    public func pushEvent() {
        _activityQueue.sync { [weak self] in
            self?._activityCount += 1
            self?._updateActivityIndicator()
        }
    }
    
    public func popEvent() {
        _activityQueue.sync { [weak self] in
            self?._activityCount -= 1
            self?._updateActivityIndicator()
        }
    }
    
    //MARK: private property
    private var _activityCount: Int = 0
    private var _activityQueue = DispatchQueue(label: "YNetworkActivitySchedulerQueue")
}

extension YNetworkActivityScheduler {
    private func _updateActivityIndicator() {
        DispatchQueue.main.async {
            if #available(iOS 13, *) {
                //do sth other
            } else {
                UIApplication.shared.isNetworkActivityIndicatorVisible = self._activityCount > 0
            }
        }
    }
}
