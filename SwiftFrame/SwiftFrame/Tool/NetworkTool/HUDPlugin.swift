//
//  HUDPlugin.swift
//  SwiftFrame
//
//  Created by msxf on 2018/9/19.
//  Copyright © 2018年 thc. All rights reserved.
//

import UIKit
import Moya
import Result

///判断是否需要token,不是每个接口都需要token
protocol HUDTargetType: TargetType {
    //返回是否需要授权
    var needsHUD: Bool { get }
}



class HUDPlugin: PluginType {
    
    /// 在发送之前调用来修改请求
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        request.timeoutInterval = 15 //超时时间
        return request
    }
    
    
    //开始发起请求
    func willSend(_ request: RequestType, target: TargetType) {
        guard let target = target as? HUDTargetType
            ,target.needsHUD
            else { return }
        //请求时在界面中央显示一个活动状态指示器
        HUDTool.showLoading()
    }
    
    //收到请求
    func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        
        HUDTool.hiddenLoading()
        //只有请求错误时会继续往下执行
        guard case let Result.failure(error) = result else { return }

        HUDTool.showText(error.errorDescription ?? "请求失败")
    }
}
