//
//  HUDTool.swift
//  SwiftFrame
//
//  Created by mac on 2018/6/27.
//  Copyright © 2018年 thc. All rights reserved.
//

import UIKit

extension MBProgressHUD{
    
    //显示等待消息
    class func showWait(_ title: String) -> MBProgressHUD{
        let view = viewToShow()
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = title
        hud.mode = MBProgressHUDMode.indeterminate
        hud.label.textColor = UIColor.white
        hud.bezelView.color = UIColor.black
        hud.removeFromSuperViewOnHide = true
        return hud
    }
    
    //显示普通消息
    class func showInfo(_ title: String) {
        let view = viewToShow()
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .customView //模式设置为自定义视图

        hud.label.text = title
        hud.label.textColor = UIColor.white
        hud.bezelView.color = UIColor.black
        hud.removeFromSuperViewOnHide = true
        
    }
    
    //显示成功消息
    class func showSuccess(_ title: String) {
        let view = viewToShow()
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .customView //模式设置为自定义视图
        hud.customView = UIImageView(image: UIImage(named: "tick")!) //自定义视图显示图片
        hud.label.text = title
        hud.removeFromSuperViewOnHide = true
        //HUD窗口显示1秒后自动隐藏
        hud.hide(animated: true, afterDelay: 1)
    }
    
    //显示失败消息
    class func showError(_ title: String) {
        let view = viewToShow()
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .customView //模式设置为自定义视图
        hud.label.text = title
        hud.label.textColor = UIColor.white
        hud.bezelView.color = UIColor.black
        hud.removeFromSuperViewOnHide = true
        //HUD窗口显示1秒后自动隐藏
        hud.hide(animated: true, afterDelay: 1)
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
}

class HUDTool: NSObject {

}
