//
//  LogPlugin.swift
//  SwiftFrame
//
//  Created by msxf on 2018/9/20.
//  Copyright © 2018年 thc. All rights reserved.
//

import UIKit
import Moya
import Result

class LogPlugin: PluginType {


    /// Called immediately before a request is sent over the network (or stubbed).
    func willSend(_ request: RequestType, target: TargetType){
        let url = target.baseURL.path + target.path
        
        
        CLog("=========URL==========" + url)
        CLog(target)
    }
    
    /// Called after a response has been received, but before the MoyaProvider has invoked its completion handler.
    func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType){
        
        switch result {
        case .success(let response):
            
            do {
                let jsonObiect = try response.mapJSON()
                CLog(jsonObiect)
            } catch {
                CLog("无数据")
            }
        default: break
            
        }
    }
    

    
}
