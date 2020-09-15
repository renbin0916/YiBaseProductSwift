//
//  YAPI.swift
//  YiBaseProductSwift
//
//  Created by 任斌 on 2020/8/19.
//  Copyright © 2020 任斌. All rights reserved.
//

import Foundation
import Moya

/// it's a use example, when we request data from our server we should creat a new one, like named ServerAPI.swift
enum YAPI {
    case requestSimpleData
    case login(account: String, passWord: String)
}

extension YAPI: TargetType {
    
    var baseURL: URL {
        #if DEBUG
        return URL(string: "https:www.baidu.com")!
        #elseif PREVIEW
        return URL(string: "https:www.acfun.com")!
        #else
        return URL(string: "https:www.qidian.com")!
        #endif
    }
    
    var path: String {
        switch self {
        case .login:
            return "api/login"
        case .requestSimpleData:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .requestSimpleData:
            return .get
        }
    }
    
    var sampleData: Data {
        return String.y_empty.data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .requestSimpleData:
            return .requestPlain
        case .login(let account, let passWord):
            return .requestParameters(parameters: ["account": account, "pwd": passWord], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .requestSimpleData:
            return nil
        case .login:
            return ["token": "1234567"]
        }
    }
}
