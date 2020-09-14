//
//  AppDelegate.swift
//  YiBaseProductSwift
//
//  Created by 任斌 on 2020/8/13.
//  Copyright © 2020 任斌. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        _initWindow()
        return true
    }

}

//MARK: private func
extension AppDelegate {
    private func _initWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = YBaseNavigationController(rootViewController: ViewController())
        window?.makeKeyAndVisible()
    }
}
