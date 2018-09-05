//
//  UITextView+Extension.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/12.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

extension UITextView{
    
    /// 设置placeholer
    ///
    /// - Parameter hc_placeHolerLabel:
    func setC_placeHolerLabel(_ hc_placeHolerLabel:String) {
        let label = UILabel()
        label.text = hc_placeHolerLabel
        label.numberOfLines = 0
        label.textColor = UIColor(red: 201, green: 201, blue: 207, alpha: 1)
        label.sizeToFit()
        self.addSubview(label)
        label.font = self.font
        self.setValue(label, forKey: "_placeholderLabel")
    }
    //获取placeholer
    func C_placeHolerLabel()->String{
        
        if let label = self.value(forKey: "_placeholderLabel") as? UILabel {
            return label.text ?? ""
        }
        
        return ""
        
    }
    /// 设置placeholer的颜色
    ///
    /// - Parameter hc_placeHolerLabel:
    func setC_placeHolerColor(_ color:UIColor) {
        guard let label = self.value(forKey: "_placeholderLabel") as? UILabel else{
            return
        }
        label.textColor = color
    }
    
    /// 获取placeholer的颜色
    ///
    /// - Returns:
    func placeHolerColor() -> UIColor{
        guard let label = self.value(forKey: "_placeholderLabel") as? UILabel else{
            return self.textColor ?? UIColor.gray
        }
        return label.textColor
    }
    
    /// 设置placeholer的font
    ///
    /// - Parameter hc_placeHolerLabel:
    func setC_placeHolerFont(_ color:UIFont) {
        guard let label = self.value(forKey: "_placeholderLabel") as? UILabel else{
            return
        }
        label.font = font
    }
    
    /// 获取placeholer的font
    ///
    /// - Returns:
    func placeHolerColor() -> UIFont{
        guard let label = self.value(forKey: "_placeholderLabel") as? UILabel else{
            return self.font ?? UIFont.systemFont(ofSize: 17)
        }
        return label.font
    }
    
    /// 限制输入长度
    ///
    /// - Parameter length: 长度
    public func c_limitLength( _ length: Int ) {
        
        NotificationCenter.default.addObserver(forName: .UITextViewTextDidChange, object: nil, queue: OperationQueue.main) { (note) in
            
            if (self.text?.count)! > length && self.markedTextRange == nil {
                
                if let text = self.text {
                    
                    let index = text.index(text.startIndex, offsetBy: length)
                    self.text = String(text[..<index])
                }
            }
        }
    }
    
}
