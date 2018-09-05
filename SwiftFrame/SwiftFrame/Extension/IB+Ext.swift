//
//  IB+Ext.swift
//  IBDesignable
//
//  Created by Zebra on 2018/7/18.
//  Copyright © 2018年 Zebra. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        
        get {
            return layer.cornerRadius
        }
        set {
            clipsToBounds = true
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
}

extension UILabel {
    
    /// 国际化
    @IBInspectable var localized: String? {
        
        get {
            return text
        }
        set {
            guard let newValue = newValue else { return }
            text = newValue.localized()
        }
    }
    

}

extension UIButton {
    
    /// 国际化
    @IBInspectable var localized: String? {
        
        get {
            return titleLabel?.text
        }
        set {
            guard let newValue = newValue else { return }
            setTitle(newValue.localized(), for: UIControlState.normal)
        }
    }
    
    @IBInspectable var localizedSelected: String? {
        
        get {
            return titleLabel?.text
        }
        set {
            guard let newValue = newValue else { return }
            setTitle(newValue.localized(), for: UIControlState.selected)
        }
    }
}

var TextFieldLimitLength: UInt8 = 0
extension UITextField {
    
    @IBInspectable var localized: String? {
        
        get {
            return text
        }
        set {
            guard let newValue = newValue else { return }
            placeholder = newValue.localized()
        }
    }
    
    private var getLimitLength: Int? {
        
        get{
            return objc_getAssociatedObject(self, &TextFieldLimitLength
                ) as? Int
        }
        set{
            objc_setAssociatedObject(self, &TextFieldLimitLength, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 限制输入长度
    @IBInspectable var limitLength: Int {
        
        get {
            return getLimitLength ?? 0
        }
        set {
            
            getLimitLength = newValue
            c_limitLength(newValue)
            
        }
    }
    
    @IBInspectable var placeholderColor: UIColor? {
        
        get {
            return value(forKey: "_placeholderLabel.textColor") as? UIColor
        }
        set {
            guard let newValue = newValue else { return }
            setValue(newValue, forKeyPath: "_placeholderLabel.textColor")
        }
    }
    
    @IBInspectable var placeholderFont: UIFont? {
        
        get {
            return value(forKey: "_placeholderLabel.font") as? UIFont
        }
        set {
            guard let newValue = newValue else { return }
            setValue(newValue, forKeyPath: "_placeholderLabel.font")
        }
    }
}

var TextViewLimitLength: UInt8 = 0
extension UITextView {
    
    @IBInspectable var localized: String? {
        
        get {
            return text
        }
        set {
            guard let newValue = newValue else { return }
            self.text = newValue.localized()
        }
    }
    
    private var getLimitLength: Int? {
        
        get{
            return objc_getAssociatedObject(self, &TextFieldLimitLength
                ) as? Int
        }
        set{
            objc_setAssociatedObject(self, &TextFieldLimitLength, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 限制输入长度
    @IBInspectable var limitLength: Int {
        
        get {
            return getLimitLength ?? 0
        }
        set {
            
            getLimitLength = newValue
            c_limitLength(newValue)
        }
    }
    
    @IBInspectable var placeholder: String? {
        
        get {
            
            return C_placeHolerLabel()
        }
        set {
            
            guard let newValue = newValue else { return }
            setC_placeHolerLabel(newValue)
        }
    }
    
    @IBInspectable var placeholderColor: UIColor? {
        
        get {
            return self.placeholderColor
        }
        set {
            guard let newValue = newValue else { return }
            setC_placeHolerColor(newValue)
        }
    }
    
    @IBInspectable var placeholderFont: UIFont? {
        
        get {
            return self.placeholderFont
        }
        set {
            guard let newValue = newValue else { return }
            setC_placeHolerFont(newValue)
        }
    }
}
