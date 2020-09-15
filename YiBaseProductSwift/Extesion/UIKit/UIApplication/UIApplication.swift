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


