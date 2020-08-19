//
//  YNetWorkActivityStatusPlugin.swift
//  YiBaseProductSwift
//
//  Created by 任斌 on 2020/8/19.
//  Copyright © 2020 任斌. All rights reserved.
//

import Foundation
import Moya

class YNetWorkActivityStatusPlugin: PluginType {
    func willSend(_ request: RequestType, target: TargetType) {
        YNetworkActivityScheduler.shared.pushEvent()
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        YNetworkActivityScheduler.shared.popEvent()
    }
}
