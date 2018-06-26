//
//  SwiftTool.swift
//  SwiftFrame
//
//  Created by mac on 2018/6/5.
//  Copyright © 2018年 thc. All rights reserved.
//

import Foundation
import UIKit

class SwiftTool: NSObject {

    //MARK: -获取当前活跃的导航栏
    static func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController?
    {
        
        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        return base
        
    }
}

