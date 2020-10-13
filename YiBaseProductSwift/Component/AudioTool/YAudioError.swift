//
//  YAudioError.swift
//  YiBaseProductSwift
//
//  Created by zero_rb on 2020/10/13.
//  Copyright © 2020 任斌. All rights reserved.
//

import Foundation

public struct YAudioError: LocalizedError {
    var error: Error?
    var des: String = .y_empty
    var code: String?
    
    public var errorDescription: String? {
        return des
    }
    
    public var failureReason: String? {
        return des
    }

    public var recoverySuggestion: String? {
        return des
    }

    public var helpAnchor: String? {
        return des
    }
}
