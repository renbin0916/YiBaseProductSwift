//
//  YAPIProvider.swift
//  YiBaseProductSwift
//
//  Created by 任斌 on 2020/8/17.
//  Copyright © 2020 任斌. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import RxSwift
import PromiseKit

public struct YAPIProvider<Target: TargetType> {

    public func cancleAllTask() {
        _provider.cancleAllTask()
    }
    
    /// request data and parse it to model<Codable>
    /// - Parameter target: Moya target
    public func request<T: Codable>(target: Target) -> Promise<T> {
        return Promise { seal in
            _provider.rx
                .request(target, callbackQueue: DispatchQueue.global())
                .observeOn(ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global()))
                .map { try
                    $0.filterSuccessfulStatusAndRedirectCodes()
                      .parseServerData()
                      .map(T.self)
                }
                .observeOn(MainScheduler.instance)
                .subscribe(onSuccess: {
                    seal.fulfill($0)
                }) {
                    seal.reject($0)
                }
                .disposed(by: _disposeBag)
        }
    }
    
    /// request data and parse it to String
    /// - Parameter target: Moya target
    public func requestString(target: Target) -> Promise<String> {
        return Promise { seal in
            _provider.rx
            .request(target)
            .observeOn(ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global()))
            .map { try
                $0.filterSuccessfulStatusAndRedirectCodes()
                  .mapString()
            }
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: {
                seal.fulfill($0)
            }) {
                seal.reject($0)
            }
            .disposed(by: _disposeBag)
        }
    }
    
    /// request data and parse it to json
    /// - Parameter target: Moya target
    public func requestJson(target: Target) -> Promise<Any> {
        return Promise { seal in
            _provider.rx
            .request(target)
            .observeOn(ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global()))
                .map { try
                    $0.filterSuccessfulStatusAndRedirectCodes()
                      .mapJSON(failsOnEmptyData: false)
            }
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { seal.fulfill($0) }, onError: {seal.reject($0)})
            .disposed(by: _disposeBag)
        }
    }
    
    //MARK: private property
    private let _provider = MoyaProvider<Target>(session: { () -> Session in
                                                    let configuration = URLSessionConfiguration.af.default
                                                    configuration.timeoutIntervalForRequest = 10
                                                    let tempSession = Session(configuration: configuration,
                                                                              interceptor: YRequestInterceptor())
                                                    return tempSession
                                                 }(),
                                                 plugins: [YNetWorkActivityStatusPlugin()])
    
    private let _disposeBag = DisposeBag()
    
}


extension MoyaProvider {
    public func cancleAllTask() {
        self.session.cancelAllRequests()
    }
}

extension Response {
    public func parseServerData() throws -> Response {
        do {
            let responseJson = try self.mapJSON(failsOnEmptyData: false)
            guard  let dict = responseJson as? [String: Any] else {
                throw YNetworkError.ParseJsonError
            }
            if let error = _parseServerError(dict) { throw error }
            return self
        } catch {
            throw error
        }
    }
    
    
    /// when the server data is in correct formatter, but there is sth. happened, we will do sth. in this func
    private func _parseServerError(_ dict: [String: Any]) -> Error? {
//        if let code = dict["statusCode"] as? Int, [10000, 20000].contains(code) {
//            let message = dict["message"] as? String
//            return YNetworkError.ServerDefineError(code: code, message: message ?? "")
//        }
        return nil
    }
}
