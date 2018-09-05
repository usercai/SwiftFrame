//
//  GlobalFnction.swift
//  SwiftFrame
//
//  Created by mac on 2018/8/7.
//  Copyright © 2018年 thc. All rights reserved.
//

import UIKit

//全局函数

//封装的日志输出功能（T表示不指定日志信息参数类型）
func CLog<T>(_ message:T, file:String = #file, function:String = #function,
              line:Int = #line) {
    #if DEBUG
    //获取文件名
    let fileName = (file as NSString).lastPathComponent
    //打印日志内容
    print("\(fileName):\(line) \(function) | \(message)")
    #endif
    
}


