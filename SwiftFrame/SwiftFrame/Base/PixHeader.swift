
//
//  PixHeader.swift
//  SwiftFrame
//
//  Created by mac on 2018/6/8.
//  Copyright © 2018年 thc. All rights reserved.
//

import UIKit

/// 当前系统版本
let kVersion = (UIDevice.current.systemVersion as NSString).floatValue

/// UIScreen.main.bounds
let kBounds = UIScreen.main.bounds

/// UIScreen.main.bounds.size
let kSize   = kBounds.size

/// UIScreen.main.bounds.size.width
let kWidth  = kSize.width

/// UIScreen.main.bounds.size.height
let kHeight = kSize.height

/// 按钮的高度
let kBtnHeight:CGFloat = 44.0

let kNavBarHeight: CGFloat = (iPhoneX ? 88 : 64)

let kTabBarHeight: CGFloat = (iPhoneX ? 83 : 49)

let kBottomSpace: CGFloat = (iPhoneX ? 34.0 : 0.0)

let kStateHeight: CGFloat = (iPhoneX ? 34.0 : 20.0)

let KStateAndBottomSpace: CGFloat = (iPhoneX ? 34.0 + 34.0 : 20.0)

let iPhoneX:Bool = kHeight == 812

