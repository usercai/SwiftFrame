//
//  NetworkTool.swift
//  SwiftFrame
//
//  Created by msxf on 2018/9/18.
//  Copyright © 2018年 thc. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import RxCocoa



class NetworkTool: NSObject {
    
    typealias R = NetworkResponse
    let APIProvider = MoyaProvider<MultiTarget>(plugins:
    [
        TokenPlugin(tokenClosure: { return UserModel.shareInstance.token })

        ])
    
    
//    func request(ApiService:MultiTarget) -> Observable<R> {
////        guard let api = ApiService.target as? CacheTarget else {
////
////        }
//    }
    
    func loadDataFromNetworkWithTarget(target:MultiTarget,success:@escaping (R)->Void,failure:@escaping (RxSwiftMoyaError?)->Void)  {
        APIProvider.request(target) { (result) in
            switch result{
            case let .success(response):
                guard let json = try? response.mapJSON(),
                let dic = json as? [String:Any],
                let response = R.deserialize(from: dic)
                else{
                    failure(RxSwiftMoyaError.ParseJSONError)
                    return
                }
                success(response)
                guard
                    //判断是否是需要缓存
                    let target = target as? CacheTarget,
                    target.needsCache
                    else {
                        return
                }
                //缓存数据
                
                break
            case let .failure(error):
                
                break
            }
        }
    }
    
    
    func saveCache(key:String,Value:Any){

        
    }
    
}
