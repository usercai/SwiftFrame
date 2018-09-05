//
//  UIButton+Ext.swift
//  SwiftFrame
//
//  Created by mac on 2018/8/29.
//  Copyright © 2018年 thc. All rights reserved.
//

import UIKit
//button 点击事件
var CButtonClickKey:UInt8 = 0

typealias CButtonClick = (_ btn:UIButton) -> Void
extension UIButton{
    
    private var click:CButtonClick?{
        get{
            return objc_getAssociatedObject(self, &CButtonClickKey) as? CButtonClick
        }
        set{
            //policy：关联策略。有五种关联策略。
//            OBJC_ASSOCIATION_ASSIGN 等价于 @property(assign)。
//            OBJC_ASSOCIATION_RETAIN_NONATOMIC等价于 @property(strong, nonatomic)。
//            OBJC_ASSOCIATION_COPY_NONATOMIC等价于@property(copy, nonatomic)。
//            OBJC_ASSOCIATION_RETAIN等价于@property(strong,atomic)。
//            OBJC_ASSOCIATION_COPY等价于@property(copy, atomic)。

            objc_setAssociatedObject(self, &CButtonClickKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
            
            self.removeTarget(self, action: #selector(buttonClick), for: .touchUpInside)
            if click != nil {
                self.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
            }
        }
    }
    
    func addClick(_ click:@escaping CButtonClick)  {
        self.click = click
    }
    
    @objc private func buttonClick() -> Void{
        self.click!(self)
    }
    
}
