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
    

    /// SwifterSwift: Border color of view; also inspectable from Storyboard.
    @IBInspectable public var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            guard let color = newValue else {
                layer.borderColor = nil
                return
            }
            // Fix React-Native conflict issue
            guard String(describing: type(of: color)) != "__NSCFType" else { return }
            layer.borderColor = color.cgColor
        }
    }
    
    /// SwifterSwift: Border width of view; also inspectable from Storyboard.
    @IBInspectable public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
}

extension UIButton {
    
    /// SwifterSwift: Image of normal state for button; also inspectable from Storyboard.
    @IBInspectable public var imageForNormal: UIImage? {
        get {
            return image(for: .normal)
        }
        set {
            setImage(newValue, for: .normal)
        }
    }
    
    /// SwifterSwift: Image of selected state for button; also inspectable from Storyboard.
    @IBInspectable public var imageForSelected: UIImage? {
        get {
            return image(for: .selected)
        }
        set {
            setImage(newValue, for: .selected)
        }
    }
    
    /// SwifterSwift: Title color of normal state for button; also inspectable from Storyboard.
    @IBInspectable public var titleColorForNormal: UIColor? {
        get {
            return titleColor(for: .normal)
        }
        set {
            setTitleColor(newValue, for: .normal)
        }
    }
    
    /// SwifterSwift: Title color of selected state for button; also inspectable from Storyboard.
    @IBInspectable public var titleColorForSelected: UIColor? {
        get {
            return titleColor(for: .selected)
        }
        set {
            setTitleColor(newValue, for: .selected)
        }
    }
    
    /// SwifterSwift: Title of normal state for button; also inspectable from Storyboard.
    @IBInspectable public var titleForNormal: String? {
        get {
            return title(for: .normal)
        }
        set {
            setTitle(newValue, for: .normal)
        }
    }
    
    /// SwifterSwift: Title of selected state for button; also inspectable from Storyboard.
    @IBInspectable public var titleForSelected: String? {
        get {
            return title(for: .selected)
        }
        set {
            setTitle(newValue, for: .selected)
        }
    }
    
}

var TextFieldLimitLength: UInt8 = 0
extension UITextField {
    
    
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
