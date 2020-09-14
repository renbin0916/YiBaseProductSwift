//
//  ViewController.swift
//  YiBaseProductSwift
//
//  Created by 任斌 on 2020/8/13.
//  Copyright © 2020 任斌. All rights reserved.
//

import UIKit

class ViewController: YBaseViewController {

}

//MARK: overrider func
extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        print("hello, world!")
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
}
