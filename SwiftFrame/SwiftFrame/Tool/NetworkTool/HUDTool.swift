//
//  HUDTool.swift
//  SwiftFrame
//
//  Created by mac on 2018/6/27.
//  Copyright © 2018年 thc. All rights reserved.
//

import UIKit

class HUDTool: NSObject {
    
    static var loadingKey:Int = 0
    
    private class func showloading(_ text:String? = nil) -> MBProgressHUD{
        
        let hud = MBProgressHUD.showAdded(to: viewToShow() , animated: true)
        hud.mode = .indeterminate
        hud.label.text = text
        UIActivityIndicatorView.appearance(whenContainedInInstancesOf:
            [MBProgressHUD.self]).color = .white
        objc_setAssociatedObject(self, &loadingKey, hud, .OBJC_ASSOCIATION_RETAIN)
        hud.bezelView.backgroundColor = UIColor.black
        hud.removeFromSuperViewOnHide = false
        return hud
    }
    
    @discardableResult class func showLoading(_ text:String? = nil) -> MBProgressHUD {
        
        guard let hud = objc_getAssociatedObject(self, &loadingKey) as? MBProgressHUD else {
            let hud = HUDTool.showloading(text)
            return hud
        }
//        hud.hide(animated: true)
//
//        hud = HUDTool.showloading(text)
        hud.show(animated: true)
        return hud
        
        
    }
    
    //获取用于显示提示框的view
    class func viewToShow() -> UIView {
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != UIWindowLevelNormal {
            let windowArray = UIApplication.shared.windows
            for tempWin in windowArray {
                if tempWin.windowLevel == UIWindowLevelNormal {
                    window = tempWin;
                    break
                }
            }
        }
        return window!
    }
    
    
    class func hiddenLoading() {
        
        guard let hud = objc_getAssociatedObject(self, &loadingKey) as? MBProgressHUD else { return }
        
        hud.hide(animated: true)
        
        
    }
    
    @discardableResult class func showText(_ text:String) -> MBProgressHUD {
        let hud = MBProgressHUD.showAdded(to: viewToShow() , animated: true)
        
        hud.mode = .text
        hud.label.text = text
        UIActivityIndicatorView.appearance(whenContainedInInstancesOf: [MBProgressHUD.self]).color = UIColor.white
        objc_setAssociatedObject(self, &loadingKey, hud, .OBJC_ASSOCIATION_RETAIN)
        hud.bezelView.backgroundColor = UIColor.black
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: 1.3)
        return hud
    }
}
