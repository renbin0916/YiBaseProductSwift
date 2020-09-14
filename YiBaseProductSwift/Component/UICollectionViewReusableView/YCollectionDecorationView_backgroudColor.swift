//
//  YCollectionDecorationView_backgroudColor.swift
//  YiBaseProductSwift
//
//  Created by zero_rb on 2020/9/14.
//  Copyright © 2020 任斌. All rights reserved.
//

import UIKit

class YCollectionDecorationView_backgroudColor: UICollectionReusableView {
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if let usedLayoutAttributes = layoutAttributes as? YCollectionViewLaoutAttributes_backgroundColor {
            self.backgroundColor = usedLayoutAttributes.backgroudColor
        }
    }
}
