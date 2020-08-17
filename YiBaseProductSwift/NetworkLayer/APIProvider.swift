//
//  APIProvider.swift
//  YiBaseProductSwift
//
//  Created by 任斌 on 2020/8/17.
//  Copyright © 2020 任斌. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import PromiseKit

public struct APIProvider<Target: TargetType> {
    private let _privider = MoyaProvider<Target>(session: { () -> Session in
        let temp = Session.default
        return Session.default
    }(), plugins: [])
}
