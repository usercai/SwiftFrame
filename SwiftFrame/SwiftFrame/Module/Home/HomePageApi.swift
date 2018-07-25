//
//  HomePageApi.swift
//  SwiftFrame
//
//  Created by mac on 2018/6/6.
//  Copyright © 2018年 thc. All rights reserved.
//

import UIKit
import Moya

var BaseURL = "http://47.94.254.180:8003/"


enum HomePageApi{
    ///登陆 username password type
    case UserLogin(String,String,String)
    // MARK: - 获取通知列表
    case QueryInfoList(isCarousel:Int,pageIndex:Int,pageSize:Int)
    
}

extension HomePageApi: TargetType {
    
    var baseURL: URL {
        
        return URL(fileURLWithPath: BaseURL)
    }
    
    var path: String {
        switch self {
        case .UserLogin(_, _, _):
            
            return "api/Login/UserLogin"
        case .QueryInfoList(_, _, _):
            return "api/Notice/QueryInfoList"
            
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!

    }
    
    var task: Task {
        var DataArray:[String:String] = ["Key":kUserInfo.Key]

        switch self {
        case .UserLogin(let username, let password, let type):
            DataArray["username"] = username
            DataArray["password"] = password.md5()
            DataArray["type"] = type
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .QueryInfoList(let isCarousel, let pageIndex, let pageSize):
            DataArray["isCarousel"] = isCarousel.string()
            DataArray["pageIndex"] = pageIndex.string()
            DataArray["pageSize"] = pageSize.string()
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        default: break
            
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }

}

let homePageTool = MoyaProvider<HomePageApi>()

