//
//  UITextField+Ext.swift
//  SwiftFrame
//
//  Created by mac on 2018/8/8.
//  Copyright © 2018年 thc. All rights reserved.
//

import UIKit

extension UITextField{
    /// 限制输入长度
    ///
    /// - Parameter length: 长度
    public func c_limitLength( _ length: Int ) {
        
        NotificationCenter.default.addObserver(forName: .UITextFieldTextDidChange, object: nil, queue: OperationQueue.main) { (note) in
            
            if (self.text?.count)! > length && self.markedTextRange == nil {
                
                if let text = self.text {
                    
                    let index = text.index(text.startIndex, offsetBy: length)
                    self.text = String(text[..<index])
                }
            }
        }
    }
}
