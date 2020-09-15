//
//  UIImage+Y.swift
//  YiBaseProductSwift
//
//  Created by zero_rb on 2020/9/15.
//  Copyright © 2020 任斌. All rights reserved.
//

import Foundation

extension UIImage {
    public func y_originalImage() -> UIImage {
        return self.withRenderingMode(.alwaysOriginal)
    }
    
    public static func image(with color: UIColor) -> UIImage? {
        let rect = CGRect(origin: .zero, size: CGSize(width: 1, height: 1))
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        let contenxt = UIGraphicsGetCurrentContext()
        contenxt?.setFillColor(color.cgColor)
        contenxt?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    public func y_cropping(to rect: CGRect) -> UIImage? {
        if let temp = cgImage?.cropping(to: rect) {
            return UIImage(cgImage: temp)
        }
        return nil
    }
}
