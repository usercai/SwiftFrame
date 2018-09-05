//
//  UIView+Ext.swift
//  SwiftFrame
//
//  Created by mac on 2018/6/6.
//  Copyright © 2018年 thc. All rights reserved.
//

import Foundation
import UIKit

typealias TapGesClick = (_ Tap:UITapGestureRecognizer) -> Void
var TapGesKey:UInt8 = 1
typealias LongGesClick = (_ Long:UILongPressGestureRecognizer) -> Void
var LongGesKey:UInt8 = 2

extension UIView{

    //添加点击手势
    private var tapClick:TapGesClick?{
        get{
            return objc_getAssociatedObject(self, &TapGesKey) as? TapGesClick
        }
        set{
            objc_setAssociatedObject(self, &TapGesKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
            
        }
    }
    
    @discardableResult
    func addTapGesture(_ tap:@escaping TapGesClick) -> UITapGestureRecognizer? {
        self.tapClick = tap

        self.isUserInteractionEnabled = true
        //一个view只会存在一个tap,后面加的会替换掉
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        self.addGestureRecognizer(tap)
        return tap
    }
    
    @objc private func tapGesture(ges:UITapGestureRecognizer){
        if let tapges = self.tapClick {
            tapges(ges)
        }
    }
    
    //添加长按手势
    private var longClick:LongGesClick?{
        get{
            return objc_getAssociatedObject(self, &LongGesKey) as? LongGesClick
        }
        set{
            objc_setAssociatedObject(self, &LongGesKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
            
        }
    }
    @discardableResult
    func addLongGesture(_ tap:@escaping LongGesClick) -> UILongPressGestureRecognizer? {
        self.longClick = tap
        
        self.isUserInteractionEnabled = true
        //一个view只会存在一个tap,后面加的会替换掉
        let tap = UILongPressGestureRecognizer(target: self, action: #selector(longGesture(ges:)))
        self.addGestureRecognizer(tap)
        return tap
    }
    
    @objc private func longGesture(ges:UILongPressGestureRecognizer){
        if let tapges = self.longClick {
            tapges(ges)
        }
    }
    
    /// 找到当前控件所在的控制器
    func getCurrentViewController() -> UIViewController? {
        var nextResponder = next
        repeat {
            let isVC = nextResponder?.isKind(of: UIViewController.self)
            if isVC != nil {
                return nextResponder as? UIViewController
            }
            nextResponder = nextResponder?.next
        }while (nextResponder != nil)
        return nil
    }
    
    
    /// x坐标
    ///
    /// - Returns:
    func c_x() -> CGFloat {
        return self.frame.origin.x
    }
    
    /// y坐标
    ///
    /// - Returns:
    func c_y() -> CGFloat {
        return self.frame.origin.y
    }
    
    func c_maxY() -> CGFloat {
        return self.frame.maxY
    }
    func c_maxX() -> CGFloat {
        return self.frame.maxX
    }
}
