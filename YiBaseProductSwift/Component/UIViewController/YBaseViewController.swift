//
//  YBaseViewController.swift
//  YiBaseProductSwift
//
//  Created by zero_rb on 2020/9/14.
//  Copyright © 2020 任斌. All rights reserved.
//

import UIKit

class YBaseViewController: UIViewController {
    
    //MARK: public property
    public var isHiddenNavigationLine: Bool = false {
        willSet {
            if newValue {
                _navigationLineImage = navigationController?.navigationBar.shadowImage
                navigationController?.navigationBar.shadowImage = UIImage()
            } else {
                navigationController?.navigationBar.shadowImage = _navigationLineImage
            }
        }
    }
    
    //MARK: private property
    private var _navigationLineImage: UIImage?
}

//MARK: screen ratate
extension YBaseViewController {
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}


