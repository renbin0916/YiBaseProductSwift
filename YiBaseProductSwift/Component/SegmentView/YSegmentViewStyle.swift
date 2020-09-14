
//
//  YSegmentViewStyle.swift
//  YiBaseProductSwift
//
//  Created by zero_rb on 2020/9/14.
//  Copyright © 2020 任斌. All rights reserved.
//

import UIKit

/**
 * it decide the detail of YSegmentView how show itself,
 * and when in default status,
 * the itemWidht equal to superView.width/itemCount
 * the itemHeight equal to superView.height
 */
public class YSegmentViewStyle {
    public var markViewStyle      = YMarkViewStyle()
    public var separatorViewStyle = YSeparatorStyle()
    public var defaultSelectedIndex: Int = 0
    public var isBeyoneSuperView: Bool = false
    /// it only effective when isBeyoneSuperView == true
    public var itemSize: CGSize = .zero
    
    convenience init(itemSize: CGSize = .zero, beyoneSuperView: Bool = false) {
        self.init()
        self.itemSize = itemSize
        self.isBeyoneSuperView = beyoneSuperView
    }
    
    private init() {}
    
}

/**
 * other class the YSegmentViewStyle will use
 *
 */
extension YSegmentViewStyle {
    
    /**
     * it decide YSegmentView markView's detail,
     * and the markView always in the bottom of the segmentView
     */
    public class YMarkViewStyle {
        
        public enum YMarkViewType: Equatable {
            /// no need to show markView
            case none
            /// show mark view with fixed width
            case fixedWidth(_ fixedWidth: CGFloat)
            /// show mark view with dynamic width, we just need to set item margin
            case dynamicWidth(_ itemMargin: CGFloat)
        }
        
        public var type: YMarkViewType = .none
        
        /// mark view color
        public var color: UIColor      = .clear
        
        /// mark view height
        public var height: CGFloat     = 2.0
    }
    
    /**
     * the view between two nearly items
     */
    public class YSeparatorStyle {
        
        public enum YSeparatorType: Equatable {
            /// no separator view
            case none
            /// show separator view with fixed height
            case fixedHeight(_ fixedHeight: CGFloat)
            /// give the top margin to superView, and it will set the same value to bottom
            case dynamicHeight(_ margin: CGFloat)
        }
        
        public var type: YSeparatorType = .none
        
        /// separator view color
        public var color: UIColor = .clear
        
        /// separator view width
        public var width: CGFloat = 1
    }
}
