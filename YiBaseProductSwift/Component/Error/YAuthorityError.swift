//
//  YAuthorityError.swift
//  YiBaseProductSwift
//
//  Created by zero_rb on 2020/10/13.
//  Copyright © 2020 任斌. All rights reserved.
//

import Foundation

public enum YAuthorityError: Swift.Error {
    case denied
    case unknown
}

extension YAuthorityError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .denied:
            return String.authority_denied
        case .unknown:
            return String.authority_unknown
        }
    }
}
