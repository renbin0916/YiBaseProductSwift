
//
//  YSegmentViewFlowLayout.swift
//  YiBaseProductSwift
//
//  Created by zero_rb on 2020/9/14.
//  Copyright © 2020 任斌. All rights reserved.
//

import UIKit

public class YSegmentViewFlowLayout: UICollectionViewFlowLayout {
    
    //MARK: property
    private var _segmentStyle: YSegmentViewStyle!
    private var _cellAmount: Int!
    private let _reusedDecorationViewID = YCollectionDecorationView_backgroudColor.className
    
    //MARK: getter
    private var _width: CGFloat {
        guard let _collectionView = collectionView else { return 0 }
        if _segmentStyle.isBeyoneSuperView {
            return _segmentStyle.itemSize.width
        } else {
            return _collectionView.frame.size.width / CGFloat(_cellAmount)
        }
    }
    
    private var _height: CGFloat {
        guard let _collectionView = collectionView else { return 0 }
        if _segmentStyle.isBeyoneSuperView {
            return _segmentStyle.itemSize.height
        } else {
            return _collectionView.frame.size.height
        }
    }
    
    //MARK: init
    convenience init(segmentStyle: YSegmentViewStyle, cellAmount: Int) {
        self.init()
        _segmentStyle = segmentStyle
        _cellAmount   = cellAmount
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: overrider
    
    private override init() {
        super.init()
    }
    
    public override func prepare() {
        super.prepare()
        itemSize = CGSize(width: _width, height: _height)
        scrollDirection = .horizontal
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        _registerDecorationViewIfNeeded()
    }
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let superAttributes = super.layoutAttributesForElements(in: rect) ??
            []
        var resultAttributes = [UICollectionViewLayoutAttributes]()
        superAttributes.forEach { att in
            resultAttributes.append(att.copy() as! UICollectionViewLayoutAttributes)
        }
        
        if _segmentStyle.separatorViewStyle.type != .none {
            for att in superAttributes {
                if let temp = layoutAttributesForDecorationView(ofKind: _reusedDecorationViewID, at: att.indexPath) {
                    resultAttributes.append(temp)
                }
            }
        }
        return resultAttributes
    }
    
    public override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = YCollectionViewLaoutAttributes_backgroundColor(forDecorationViewOfKind: elementKind, with: indexPath)
        if elementKind == _reusedDecorationViewID && indexPath.row < _cellAmount - 1 {
            let tempAttributes = layoutAttributesForItem(at: indexPath)
            switch _segmentStyle.separatorViewStyle.type  {
            case .none:
                return nil
            case .fixedHeight(let fixedHeight):
                let tempOriginY = tempAttributes?.frame.midY ?? 0
                let topMargin = (tempAttributes?.frame.height ?? 0) - fixedHeight/2.0
                attributes.frame = CGRect(x: (tempAttributes?.frame.maxX ?? 0) - _segmentStyle.separatorViewStyle.width/2.0,
                                          y: tempOriginY + topMargin,
                                          width: _segmentStyle.separatorViewStyle.width,
                                          height: fixedHeight)
            case .dynamicHeight(let margin):
                let tempOriginY = tempAttributes?.frame.minY ?? 0
                let topMargin   = margin/2.0
                attributes.frame = CGRect(x: (tempAttributes?.frame.maxX ?? 0) - _segmentStyle.separatorViewStyle.width/2.0,
                                          y: tempOriginY + topMargin,
                                          width: _segmentStyle.separatorViewStyle.width,
                                          height: (tempAttributes?.frame.height ?? 0) - margin)
            }
            attributes.backgroudColor = _segmentStyle.separatorViewStyle.color
            attributes.zIndex = Int.max
            return attributes
        }
        return nil
    }
}

extension YSegmentViewFlowLayout {
    
    private func _registerDecorationViewIfNeeded() {
        if _segmentStyle.separatorViewStyle.type != .none {
            register(YCollectionDecorationView_backgroudColor.self, forDecorationViewOfKind: _reusedDecorationViewID)
        }
    }
}
