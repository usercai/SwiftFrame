//
//  UIView+Ext.swift
//  SwiftFrame
//
//  Created by mac on 2018/6/6.
//  Copyright © 2018年 thc. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
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
    
    
}
