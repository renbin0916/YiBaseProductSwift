//
//  CATextLayer_center.swift
//  YiBaseProductSwift
//
//  Created by zero_rb on 2020/9/14.
//  Copyright © 2020 任斌. All rights reserved.
//

import Foundation
import QuartzCore

class CATextLayer_center: CATextLayer {
    override func draw(in ctx: CGContext) {
        let height = self.bounds.size.height
        let fontSize = self.fontSize
        let yDiff    = (height - fontSize).y_half - fontSize/10
        ctx.saveGState()
        ctx.translateBy(x: 0.0, y: yDiff)
        super.draw(in: ctx)
        ctx.restoreGState()
    }
}
