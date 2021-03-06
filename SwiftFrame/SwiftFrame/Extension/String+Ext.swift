//
//  String+Ext.swift
//  SwiftFrame
//
//  Created by mac on 2018/6/6.
//  Copyright © 2018年 thc. All rights reserved.
//

import Foundation
import UIKit

extension String{
    
    /// 国际化
    ///
    /// - Returns: 
    func localized() -> String{
        
        return NSLocalizedString(self, comment: "")
    }
    /// md5加密
    ///
    /// - Returns:
    func md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize(count: digestLen)
        free(result)
        return String(format: hash as String)
    }
    
    /// 首字母拼音
    ///
    /// - Returns:
    func toPinyin() -> String {
        let str = NSMutableString(string: self)
        CFStringTransform(str as CFMutableString, nil, kCFStringTransformMandarinLatin, false)
        CFStringTransform(str as CFMutableString, nil, kCFStringTransformStripDiacritics, false)
        let pinyin = str.capitalized
        return pinyin
    }
    
    /// base64编码
    var base64EncodedString: String? {
        get {
            let data = self.data(using: .utf8)
            return data?.base64EncodedString()
        }
    }
    
    /// base64解码
    var base64DecodedString: String? {
        get {
            if let data = Data(base64Encoded: self) {
                return String(data: data, encoding: .utf8)
            }
            return nil
        }
    }
    
    /// 转成json
    ///
    /// - Returns:
    func toJsonObject() -> Any? {
        if let data = self.data(using: .utf8) {
            return try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
        }
        return nil
    }
    
    //MARK:- 计算文字大小
    func boundingTextSize(maxSize:CGSize ,font:UIFont) -> CGSize {
        
        let str = self as NSString
        let rect = str.boundingRect(with: maxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font:font], context: nil)
        
        return rect.size
    }
    
    /// 字符串转URL
    ///
    /// - Returns:
    func url() -> URL {
        var url = self
        if self == "" {
            url = "http://"
        }
        
        return URL(string: url) ?? URL.init(string: "http://")!
    }
    
    /// 截取字符串
    ///
    /// - Parameter index: 截取到第几个
    /// - Returns: 截取后的String
    public func substring(from index: Int) -> String {
        if self.count > index {
            let startIndex = self.index(self.startIndex, offsetBy: index)
            let subString = self[startIndex..<self.endIndex]
            
            return String(subString)
        } else {
            return self
        }
    }
    
}
