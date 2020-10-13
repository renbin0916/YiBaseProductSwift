//
//  YGCDTimer.swift
//  YiBaseProductSwift
//
//  Created by zero_rb on 2020/10/13.
//  Copyright © 2020 任斌. All rights reserved.
//

import Foundation

public class YGCDTimer {
    
    private enum Timerstate {
        case suspend
        case resume
    }
    
    public typealias GCDTimerHandler = () -> Void
    private let _timeInterval: DispatchTimeInterval
    private let _callBackQueue: DispatchQueue
    private var _handler: GCDTimerHandler?
    private var _state = Timerstate.suspend
    
    private init(interval: DispatchTimeInterval,
                 callBackQueue: DispatchQueue,
                 handler: @escaping GCDTimerHandler) {
        _timeInterval  = interval
        _callBackQueue = callBackQueue
        _handler = handler
    }
    
    deinit {
        _internalTimer.setEventHandler {}
        destroy()
        _handler = nil
    }
    
    //MARK: lazy load
    private lazy var _internalTimer: DispatchSourceTimer = {
        let timer = DispatchSource.makeTimerSource(queue: _callBackQueue)
        timer.schedule(deadline: .now(), repeating: _timeInterval)
        timer.setEventHandler { [weak self] in
            self?._handler?()
        }
        return timer
    }()
}

//MARK: private func
extension YGCDTimer {
    private func _resume() {
        if _state == .resume {
            return
        }
        _state = .resume
        _internalTimer.resume()
    }
    
    private func _suspend() {
        if _state == .suspend {
            return
        }
        _state = .suspend
        _internalTimer.suspend()
    }
    
}

//MARK: public func
extension YGCDTimer {
    
    public static func repeatTimer(interval: DispatchTimeInterval,
                                   callBackQueue: DispatchQueue = .main,
                                   handler: @escaping GCDTimerHandler) -> YGCDTimer {
        return YGCDTimer(interval: interval,
                        callBackQueue: callBackQueue,
                        handler: handler)
    }
    
    @discardableResult
    public func fire() -> YGCDTimer {
        _resume()
        return self
    }
    
    @discardableResult
    public func suspend() -> YGCDTimer  {
        _suspend()
        return self
    }
    
    public func destroy() {
        _resume()
        _internalTimer.cancel()
    }
    
    @discardableResult
    public func rescheduleHandler(handler: @escaping GCDTimerHandler) -> YGCDTimer  {
        _handler = handler
        _internalTimer.setEventHandler { [weak self] in
            self?._handler?()
        }
        return self
    }
}
