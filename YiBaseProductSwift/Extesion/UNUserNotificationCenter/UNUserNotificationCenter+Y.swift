//
//  UNUserNotificationCenter+Y.swift
//  YiBaseProductSwift
//
//  Created by zero_rb on 2020/10/13.
//  Copyright © 2020 任斌. All rights reserved.
//

import Foundation
import PromiseKit

extension UNUserNotificationCenter {
    public class func requestPushAuth() -> Promise<Void> {
        return Promise { seal in
            self.current().getNotificationSettings { setting in
                switch setting.authorizationStatus {
                case .notDetermined:
                    self.current().requestAuthorization(options: [.badge, .alert, .sound]) { (result, error) in
                        DispatchQueue.main.async {
                            if result == true {
                                seal.fulfill(())
                            } else {
                                seal.reject(YAuthorityError.denied)
                            }
                        }
                    }
                case .denied, .provisional, .ephemeral:
                    seal.reject(YAuthorityError.denied)
                case .authorized:
                    seal.fulfill(())
                @unknown default:
                    seal.reject(YAuthorityError.unknown)
                }
            }
        }
    }

}
