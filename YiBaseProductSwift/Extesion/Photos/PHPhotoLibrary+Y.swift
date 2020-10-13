//
//  PHPhotoLibrary+Y.swift
//  YiBaseProductSwift
//
//  Created by zero_rb on 2020/10/13.
//  Copyright © 2020 任斌. All rights reserved.
//

import Foundation
import PromiseKit
import Photos

extension PHPhotoLibrary {
    public class func requestPhotoLibraryAuth() -> Promise<Void> {
        return Promise { seal in
            let status: PHAuthorizationStatus
            if #available(iOS 14, *) {
                status = self.authorizationStatus(for: .readWrite)
            } else {
                status = self.authorizationStatus()
            }
            switch status {
            case .notDetermined:
                self.requestAuthorization { resultStatus in
                    DispatchQueue.main.async {
                        if resultStatus != .authorized {
                            seal.reject(YAuthorityError.denied)
                        } else {
                            seal.fulfill(())
                        }
                    }
                }
            case .restricted, .denied, .limited:
                seal.reject(YAuthorityError.denied)
            case .authorized:
                seal.fulfill(())
            @unknown default:
                seal.reject(YAuthorityError.unknown)
            }
            
        }
    }
}
