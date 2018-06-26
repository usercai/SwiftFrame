//
//  UIImageView+Ext.swift
//  SwiftFrame
//
//  Created by mac on 2018/6/5.
//  Copyright © 2018年 thc. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView{
//    下载时（获取进度）或者下载完成（某些通知）需要做某些事情，这些可以写在回调中
    /// 加载图片
    ///
    /// - Parameters:
    ///   - urlStr: 网络地址
    ///   - placeHoder: 默认图
    func c_setImage(urlStr: String, placeHoder: String) {
        
        let url = URL(string: urlStr)
        let pImage = UIImage(named: placeHoder)
        if let url = url, let _ = pImage {
            self.kf.setImage(with: url, placeholder: pImage, options: [.backgroundDecode], progressBlock: { (receivedSize, totalSize) in
                print("Download Progress: \(receivedSize)/\(totalSize)")
            }) { (image, error, cacheType, imageURL) in
                print("Downloaded and set!")
            }
        }
    }
    
    func c_setImage(urlStr: String) {
        let url = URL(string: urlStr)
        if let url = url {
            self.kf.setImage(with: url)
        }
    }
    
}
