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
        
        view.backgroundColor = .yellow
        
        view.y_updateGradientLayerVertical(beginColor: .red, endColor: .black)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.view.y_updateGradientlayerHorizontal(beginColor: .red, endColor: .black)
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 6) {
            self.view.y_updateGrandLayer(beginColor: .red, endColor: .black, startPoint: .zero, endPoint: CGPoint(x: 1, y: 1))
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 9) {
            self.view.y_removeGrandientLayer()
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
}
