//
//  ObservableNetworkResponse+HandyJSON.swift
//  SwiftFrame
//
//  Created by msxf on 2018/9/18.
//  Copyright © 2018年 thc. All rights reserved.
//

import UIKit
import RxSwift
import Moya
import HandyJSON

public typealias R = NetworkResponse

extension NetworkResponse{
    
    /// 转成单个model
    ///
    /// - Parameter type: model的类型
    /// - Returns: model
    /// - Throws: 错误信息
    public func mapModel<T:HandyJSON>(_ type:T.Type) throws -> T{
        
        guard let json = data as? [String : Any] else {
            
            throw RxSwiftMoyaError.ParseJSONError
        }

        switch code{
        case 1:
            guard let model = T.deserialize(from: json) else{
                throw RxSwiftMoyaError.ParseJSONError
            }
            return model
        default:
            throw RxSwiftMoyaError.OtherError
        }
    }
    

    /// 转成model数组
    ///
    /// - Parameter type: model的类型
    /// - Returns: model数组
    /// - Throws: 错误信息
    public func mapArray<T:HandyJSON>(_ type:T.Type) throws -> [T]{
        
        guard let arr = data as? [[String : Any]] else {
            
            throw RxSwiftMoyaError.ParseJSONError
        }
        
        var models:[T] = []
        switch code{
        case 1:
            for dic in arr{
                let model = T.deserialize(from: dic)
                models.append(model!)
            }
            return models
        default:
            throw RxSwiftMoyaError.OtherError
        }
    }
    
    
    /// 请求是否成功
    ///
    /// - Returns: 是否成功
    /// - Throws: 错误信息
    public func isSuccess() throws -> Bool{
        switch code {
        case 1:
            return true
        default:
            return false
        }
    }
    
}

extension ObservableType where E == R{
    
    /// 转Model
    ///
    /// - Parameter type:
    /// - Returns:
    public func mapObejct<T:HandyJSON>(_ type:T.Type) -> Observable<T>{
        return flatMap({ (response) -> Observable<T> in
            return Observable.just(try response.mapModel(T.self))
        })
    }
    
    /// [Model]
    ///
    /// - Parameter type: model的类型
    /// - Returns: Observable<[T]>
    public func mapArray<T:HandyJSON>(_ type:T.Type) -> Observable<[T]>{
        return flatMap { response -> Observable<[T]> in
            return Observable.just(try response.mapArray(T.self))
        }
    }

    /// 返回是否请求成功针对只需要结果的
    ///
    /// - Returns:
    public func isSuccess() -> Observable<Bool>{
        return flatMap { response -> Observable<Bool> in
            return Observable.just(try response.isSuccess())
        }
    }
}




