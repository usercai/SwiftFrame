//
//  TokenPlugin.swift
//  SwiftFrame
//
//  Created by msxf on 2018/9/18.
//  Copyright © 2018年 thc. All rights reserved.
//

import UIKit
import Moya

//用于存储令牌字符串
class TokenSource {
    var token: String?
    init() { }
}

///判断是否需要token,不是每个接口都需要token
protocol TokenTargetType: TargetType {
    //返回是否需要授权
    var needsToken: Bool { get }
}


///用于给请求加token
struct TokenPlugin: PluginType {
    //获取令牌字符串方法
    let tokenClosure: () -> String?
    
    //准备发起请求
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        
        var request = request
        guard
            //判断是否是需要token
            let target = target as? TokenTargetType,
            target.needsToken
            else {
                return request
        }
        //获取获取令牌字符串
        if let token = tokenClosure() {
            //将token添加到请求头中
            request.addValue(token, forHTTPHeaderField: "Authorization")
        }
        return request
    }
}


