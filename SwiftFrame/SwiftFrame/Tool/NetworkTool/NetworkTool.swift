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
    static let APIProvider = MoyaProvider<MultiTarget>(plugins:
    [
        TokenPlugin(tokenClosure: { return UserModel.shareInstance.token }),
        NetworkActivityPlugin(networkActivityClosure: { (type, target) in
            switch type {
            case .began:
                DispatchQueue.main.async {
                    HUDTool.showLoading()
                }
                
            case .ended:
                DispatchQueue.main.async {
                    HUDTool.hiddenLoading()
                }
            }
        }),
        LogPlugin()

        ])
    
    
    public static func request(_ ApiService:TargetType) -> Observable<R> {

        guard ApiService is CacheTarget else {
            //不遵循cacheTarget,不需要缓存,直接走网络请求
            return Observable<R>.create({ (observer) -> Disposable in
                self.loadDataFromNetworkWithTarget(target: ApiService, success: { (response) in
                    observer.onNext(response)
                    observer.onCompleted()
                }, failure: { (error) in
                    observer.onError(error ?? RxSwiftMoyaError.OtherError)
                })
                return Disposables.create()
            }).observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            
        }
        //遵循缓存协议
        //查看是否需要缓存
        return Observable<R>.create({ (observ) -> Disposable in
            self.loadDataFromCacheWithTarget(target: ApiService, success: { (response, iscache) in
                observ.onNext(response)
                //如果不是缓存走结束
                if !iscache{
                    observ.onCompleted()
                }
            }) { (error) in
                observ.onError(error ?? RxSwiftMoyaError.OtherError)
            }
            return Disposables.create()
        }).observeOn(MainScheduler.instance)
        .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))

        

    }
    
    
    /// 不需要加载缓存,直接加载网络数据
    /// 根据是否
    /// - Parameters:
    ///   - target: <#target description#>
    ///   - success: <#success description#>
    ///   - failure: <#failure description#>
    private static func loadDataFromNetworkWithTarget(target:TargetType,success:@escaping (R)->Void,failure:@escaping (RxSwiftMoyaError?)->Void)  {
        
        APIProvider.request(MultiTarget(target)) { (result) in
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
                    //重复验证,判断是否是需要缓存
                    let target = target as? CacheTarget,
                    target.needsCache
                    else {
                        return
                }
                //缓存数据
                let url = target.baseURL.path + target.path
                CachePlugin.saveCacheData(key: url, value: dic)
                
                break
            case let .failure(error):
                
                break
            }
        }
    }

    //走缓存
    
    /// 从缓存取数据
    ///
    /// - Parameters:
    ///   - target:
    ///   - success: 数据  是否是缓存数据
    ///   - failure:
    private static func loadDataFromCacheWithTarget(target:TargetType,success:@escaping (R,Bool)->Void,failure:@escaping (RxSwiftMoyaError?)->Void)  {
        //key
        let url = target.baseURL.path + target.path

        guard
            //重复验证,判断是否是需要缓存
            let Target = target as? CacheTarget,
            Target.needsCache
            else {
                //不需要缓存直接走网络接口
                loadDataFromNetworkWithTarget(target: target, success: { (response) in
                    success(response, false)
                }) { (error) in
                    failure(error)
                }
                return
        }
        
        //需要缓存
        
        //查看是否有缓存
        CachePlugin.isCache(key: url) { (iscache) in
            if iscache{
                //存在缓存
                //获取缓存
                CachePlugin.getCacheData(key: url, success: { (data) in
                    guard let dic = data as? [String:Any] else{
                        failure(RxSwiftMoyaError.ParseJSONError)
                        return
                    }
                    success(R.deserialize(from: dic)!, true)
                })
            }
        }
        
        //无论有没有缓存都返回网络数据
        loadDataFromNetworkWithTarget(target: target, success: { (response) in
            success(response, false)
        }, failure: { (error) in
            failure(error)
        })
        

    }
}
