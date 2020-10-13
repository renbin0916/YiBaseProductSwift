//
//  UIApplication.swift
//  YiBaseProductSwift
//
//  Created by zero_rb on 2020/9/15.
//  Copyright © 2020 任斌. All rights reserved.
//

import Foundation

extension UIApplication {
    
    public var rootVC: UIViewController? {
        return keyWindow?.rootViewController
    }
    
    /// get the top vc
    public func visibleVC(vc: UIViewController? = UIApplication.shared.rootVC) -> UIViewController? {
        if let presented = vc?.presentingViewController {
            return visibleVC(vc: presented)
        }
        if let tab = vc as? UITabBarController {
            if let selected = tab.selectedViewController {
                return visibleVC(vc: selected)
            }
        }
        if let nav = vc as? UINavigationController {
            return visibleVC(vc: nav.visibleViewController)
        }
        return vc
    }
    
    public func replaceRootVC(_ vc: UIViewController, animate: Bool = true) {
        let fromView = UIScreen.main.snapshotView(afterScreenUpdates: false)
        guard let viewcontroller = UIApplication.shared.rootVC, viewcontroller.presentedViewController != nil else {
            _changeRootViewContrller(vc,
                                     from: fromView,
                                     animate: animate)
            return
        }
        viewcontroller.dismiss(animated: false) { [weak self] in
            guard let self = self else {return}
            self._changeRootViewContrller(vc,
                                          from: fromView,
                                          animate: animate)
        }
    }
    
    public class func canOpenSettingPage() -> Bool {
        guard let url = URL(string: UIApplication.openSettingsURLString) else {
            return false
        }
        return self.shared.canOpenURL(url)
    }
    
    public class func openSettingPage() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        self.shared.open(url, options: [:], completionHandler: nil)
    }
    
    #warning(" 文字内容根据项目要求完善")
    public class func showSettingPathAlert() {
        let alertController =  UIAlertController(title: "你已关闭权限", message: "你可以到 设置-隐私-照片 中设置权限，启用功能", preferredStyle: .alert)
        let a1 = UIAlertAction(title: "知道了", style: .cancel, handler: nil)
        alertController.addAction(a1)
        
        self.shared.rootVC?.present(alertController, animated: true, completion: nil)
    }
    
    #warning(" 文字内容根据项目要求完善")
    public class func showSettingPageAlert() {
        let alertController =  UIAlertController(title: "你已关闭权限", message: "你需要设置权限，打开功能吗？", preferredStyle: .alert)
        let a1 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let a2 = UIAlertAction(title: "好的", style: .default) { _ in
            UIApplication.openSettingPage()
        }
        alertController.addAction(a1)
        alertController.addAction(a2)
        self.shared.rootVC?.present(alertController, animated: true, completion: nil)
    }
    
    
    private func _changeRootViewContrller(_ vc: UIViewController,
                                          from: UIView,
                                          animate: Bool = true) {
        keyWindow?.rootViewController = vc
        if animate {
            guard let kw = keyWindow else {
                return
            }
            kw.addSubview(from)
            from.frame = kw.bounds
            UIView.animate(withDuration: .y_animateTime_hide, animations: {
                from.transform = CGAffineTransform(scaleX: 2, y: 2)
                from.alpha = 0
            }) { _ in
                from.removeFromSuperview()
            }
        }
    }
}


