//
//  YNetworkError.swift
//  YiBaseProductSwift
//
//  Created by 任斌 on 2020/8/19.
//  Copyright © 2020 任斌. All rights reserved.
//

import Foundation
import Moya

public enum YNetworkError: Swift.Error {
    case ParseJsonError
    case ServerDefineError(code: Int, message: String)
    case ServerDataError
    case UnkonwError
}

extension YNetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .ParseJsonError:
            return String.parseJsonErrorString
        case .ServerDefineError(_, let message):
            return message
        case .ServerDataError:
            return String.serverDataErrorString
        case .UnkonwError:
            return String.unknownErrorString
        }
    }
}
