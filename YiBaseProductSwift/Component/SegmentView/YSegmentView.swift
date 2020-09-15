
//
//  YSegmentView.swift
//  YiBaseProductSwift
//
//  Created by zero_rb on 2020/9/14.
//  Copyright © 2020 任斌. All rights reserved.
//

import UIKit

public class YSegmentView<T: UICollectionViewCell & YLoadDataProtocol>: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    //MARK: property
    public var segmentViewStyle = YSegmentViewStyle()
    
    private var _collectionView: UICollectionView!
    
    public var delegate: YSegmentViewDelegate?
    
    public var datas: [T.DataType] = [T.DataType]() {
        didSet {
            _segmentReloadData()
            _markViewMove(fromIndex: self.currentSelectedIndex, toIndex: self.currentSelectedIndex, animate: false)
        }
    }
    
    public var currentSelectedIndex: Int = NSNotFound {
        willSet {
            if newValue != self.currentSelectedIndex {
                guard newValue < self.datas.count,
                    self._collectionView.numberOfSections > 0,
                    self._collectionView.numberOfItems(inSection: 0) > newValue
                    else { return }
                self._collectionView.selectItem(at: IndexPath(row: newValue, section: 0),
                                                animated: true,
                                                scrollPosition: .centeredHorizontally)
            }
        }
    }
    
    private lazy var _markView: UIView = {
        let temp = UIView()
        temp.backgroundColor = segmentViewStyle.markViewStyle.color
        _collectionView.addSubview(temp)
        return temp
    }()
    
    //MARK: life cycle
    public override init(frame: CGRect) {
        super.init(frame: frame)
        _commonInit()
        setUpMySegmentView()
    }
    
    init() {
        super.init(frame: .zero)
        _commonInit()
        setUpMySegmentView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        _commonInit()
        setUpMySegmentView()
    }
    
    //MARK: public func
    
    /// over rider this func, do some special things
    public func setUpMySegmentView() { }
    
    
    //MARK: UICollectionViewDataSource
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let className = String(describing: type(of: T.self)).components(separatedBy: ".").first else {
            fatalError("when you inheritance YSegmentView， you should give it a relative cellClass")
        }
        let reusedCell = collectionView.dequeueReusableCell(withReuseIdentifier: className, for: indexPath)
        if let cell = reusedCell as? T {
            if indexPath.row < datas.count {
                cell.loadData(data: datas[indexPath.row], isSelected: indexPath.row == currentSelectedIndex)
            }
        }
        return reusedCell
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    //MARK: UICollectionViewDelegate
    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if delegate?.segmentViewExclueIndexs(self).contains(indexPath.row) == true {
            delegate?.segmentViewExclueIndexWillSelected(self, index: indexPath.row)
            return false
        }
        return true
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        _markViewMove(fromIndex: currentSelectedIndex, toIndex: indexPath.row)
        delegate?.segmentViewDidSelected(self, index: indexPath.row)
    }
    
}

//MARK: private func
extension YSegmentView {
    private func _commonInit() {
        translatesAutoresizingMaskIntoConstraints = false
        _initCollectionView()
        _addCollectionViewConstrait()
    }
    
    private func _initCollectionView() {
        guard let className = String(describing: type(of: T.self)).components(separatedBy: ".").first else {
            fatalError("when you inheritance YSegmentView， you should give it a relative cellClass")
        }
        let layout = YSegmentViewFlowLayout(segmentStyle: segmentViewStyle, cellAmount: 1)
        _collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        _collectionView.translatesAutoresizingMaskIntoConstraints = false
        _collectionView.backgroundColor = .clear
        _collectionView.showsVerticalScrollIndicator   = false
        _collectionView.showsHorizontalScrollIndicator = false
        _collectionView.register(UINib(nibName: className, bundle: nil), forCellWithReuseIdentifier: className)
        _collectionView.delegate   = self
        _collectionView.dataSource = self
        addSubview(_collectionView)
    }
    
    private func _addCollectionViewConstrait() {
        [NSLayoutConstraint.Attribute.top, .left, .width].forEach
            {
                _addEqualConstraint(freedomView: _collectionView,
                                    nextView: self,
                                    attribute: $0)
        }
        let tempH = segmentViewStyle.markViewStyle.type == .none ? self.frame.height : self.frame.height - segmentViewStyle.markViewStyle.height
        _addEqualConstraint(freedomView: _collectionView,
                            nextView: self,
                            attribute: .height,
                            constant: tempH)
    }
    
    private func _addEqualConstraint(freedomView: UIView,
                                     nextView: UIView,
                                     attribute: NSLayoutConstraint.Attribute,
                                     constant: CGFloat = 0) {
        let temp = NSLayoutConstraint(item: freedomView,
                                      attribute: attribute,
                                      relatedBy: .equal,
                                      toItem: nextView,
                                      attribute: attribute,
                                      multiplier: 1.0,
                                      constant: constant)
        nextView.addConstraint(temp)
    }
    
    private func _segmentReloadData() {
        if datas.count < 1 { return }
        let layout = YSegmentViewFlowLayout(segmentStyle: segmentViewStyle, cellAmount: datas.count)
        _collectionView.setCollectionViewLayout(layout, animated: false)
        self._collectionView.reloadData()
        if currentSelectedIndex == NSNotFound {
            currentSelectedIndex = segmentViewStyle.defaultSelectedIndex
        }
        
        // at the first time, we can't find the correct cell, so we need wait a little time
        DispatchQueue.main.asyncAfter(deadline: .now() + 1/24) {
            self._markViewMove(fromIndex: self.currentSelectedIndex, toIndex: self.currentSelectedIndex, animate: false)
        }
        
    }
    
    private func _markViewMove(fromIndex: Int, toIndex: Int, animate: Bool = true) {
        currentSelectedIndex = toIndex
        guard segmentViewStyle.markViewStyle.type != .none,
            let toFrame = _collectionView.cellForItem(at: IndexPath(row: toIndex, section: 0))?.frame
            else { return }
        var markFrame = CGRect.zero
        switch segmentViewStyle.markViewStyle.type {
        case .fixedWidth(let fixedWidth):
            markFrame = CGRect(x: toFrame.minX + (toFrame.width - fixedWidth)/2.0,
                               y: self.frame.height - segmentViewStyle.markViewStyle.height,
                               width: fixedWidth,
                               height: segmentViewStyle.markViewStyle.height)
        case .dynamicWidth(let margin):
            markFrame = CGRect(x: toFrame.minX + margin/2.0 ,
                               y: self.frame.height - segmentViewStyle.markViewStyle.height,
                               width: toFrame.width - margin,
                               height: segmentViewStyle.markViewStyle.height)
        default:
            break
        }
        
        if animate {
            UIView.animate(withDuration: .y_animateTime_show)
            {
                self._markView.frame = markFrame
            }
        } else {
            _markView.frame = markFrame
        }
    }
}
