//
//  AVCaptureDevice+Y.swift
//  YiBaseProductSwift
//
//  Created by zero_rb on 2020/10/13.
//  Copyright © 2020 任斌. All rights reserved.
//

import Foundation
import PromiseKit
import AVFoundation

extension AVCaptureDevice {
    public class func requestCameraAuth() -> Promise<Void> {
        return Promise { seal in
            let status = self.authorizationStatus(for: .video)
            switch status {
            case .authorized:
                seal.fulfill(())
            case .denied, .restricted:
                seal.reject(YAuthorityError.denied)
            case .notDetermined:
                self.requestAccess(for: .video) { result in
                    DispatchQueue.main.async {
                        if result == true {
                            seal.fulfill(())
                        } else {
                            seal.reject(YAuthorityError.denied)
                        }
                    }
                }
            @unknown default:
                seal.reject(YAuthorityError.unknown)
            }
        }
    }
    
    public class func requestAudioAuth() -> Promise<Void> {
        return Promise { seal in
            let status = self.authorizationStatus(for: .audio)
            switch status {
            case .authorized:
                seal.fulfill(())
            case .denied, .restricted:
                seal.reject(YAuthorityError.denied)
            case .notDetermined:
                self.requestAccess(for: .video) { result in
                    DispatchQueue.main.async {
                        if result == true {
                            seal.fulfill(())
                        } else {
                            seal.reject(YAuthorityError.denied)
                        }
                    }
                }
            @unknown default:
                seal.reject(YAuthorityError.unknown)
            }
        }
    }
}
