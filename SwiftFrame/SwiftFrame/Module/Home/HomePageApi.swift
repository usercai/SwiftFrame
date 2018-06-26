//
//  HomePageApi.swift
//  SwiftFrame
//
//  Created by mac on 2018/6/6.
//  Copyright © 2018年 thc. All rights reserved.
//

import UIKit
import Moya

var BaseURL = "http://60.205.178.193:8090/"
//var BaseURL = "http://47.94.254.180:8008/api/"

enum HomePageApi{
    case Homepage(type:Int,platid:Int)
//    case login(username:String,password:String)
}

extension HomePageApi: TargetType {
    
    var baseURL: URL {
        
        return URL(fileURLWithPath: BaseURL)
    }
    
    var path: String {
        switch self {
        case .Homepage(type: _, platid: _):
            return "sv_competition/competitionList/getcompetitionListByPlatId.do"
//        case .login(username: _, password: _):
//            return "login/mobileUserLogin"
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
        
        switch self {
        case .Homepage(type: let type, platid: let platid):
            
            return .requestParameters(parameters: ["type" : type,"platid":platid], encoding: URLEncoding.default)
//        case .login(username: let username, password: let password):
//
//            let identifierNumber = UIDevice.current.identifierForVendor?.uuidString
//            let timestr = Date().c_string()
//            let token = (identifierNumber! + timestr).md5
//            let sig = (token + timestr + "SLAMBALL20180000001").md5
//
//
//            return .requestParameters(parameters: ["userAccount" : username,"userPassword":password,"token":token,"timeStamp":timestr,"lastLoginPhone":"1"], encoding: URLEncoding.default)
        default: break
            
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }

}

let homePageTool = MoyaProvider<HomePageApi>()

