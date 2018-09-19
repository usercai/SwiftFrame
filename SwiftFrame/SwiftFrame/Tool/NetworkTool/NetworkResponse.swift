//
//  NetworkResponse.swift
//  SwiftFrame
//
//  Created by msxf on 2018/9/18.
//  Copyright © 2018年 thc. All rights reserved.
//

import UIKit
import HandyJSON
///接口返回的默认数据结构

public class NetworkResponse: HandyJSON {
    
    required public init() {
    }
    var code:Int = 0
    var msg:String = ""
    var data:Any?
}

extension NetworkResponse{
    
}


