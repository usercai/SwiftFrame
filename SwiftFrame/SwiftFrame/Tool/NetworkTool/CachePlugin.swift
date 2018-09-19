//
//  CachePlugin.swift
//  SwiftFrame
//
//  Created by msxf on 2018/9/18.
//  Copyright © 2018年 thc. All rights reserved.
//

import UIKit
import Moya

///缓存协议
protocol CacheTarget : TargetType {
    
    var needsCache: Bool { get }
}

