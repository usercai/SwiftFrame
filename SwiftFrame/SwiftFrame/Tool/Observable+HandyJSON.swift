//
//  Observable+HandyJSON.swift
//  SwiftFrame
//
//  Created by mac on 2018/6/6.
//  Copyright © 2018年 thc. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import HandyJSON


extension Response{
    
    
    /// 转换成Model
    ///
    /// - Parameter type: 类型
    /// - Returns: 放回一个Model
    /// - Throws: 错误信息
    public func mapObject<T:HandyJSON>(_ type:T.Type) throws -> T{
        
        guard let json = try mapJSON() as? [String : Any] else {
            
            
            throw RxSwiftMoyaError.ParseJSONError
        }
        guard let msgCode = json["msgCode"] as? Int else {
            throw RxSwiftMoyaError.ParseJSONError
        }
        switch msgCode{
        case 1:
            if let data = json["data"] as? [String:Any]{
                return T.deserialize(from: data)!
            }else{
                throw RxSwiftMoyaError.DataNoObjectModel
            }
            
        default:
            throw RxSwiftMoyaError.OtherError
        }
    }
    
    /// 是否请求成功
    ///
    /// - Returns: msgCode为时成功
    /// - Throws:
    public func mapSuccess() throws -> Bool{
        
        guard let json = try mapJSON() as? [String : Any] else {
            
            
            throw RxSwiftMoyaError.ParseJSONError
        }
        guard let msgCode = json["msgCode"] as? Int else {
            throw RxSwiftMoyaError.ParseJSONError
        }
        switch msgCode{
        case 1:
            return true
        default:
            return false
        }
    }
    
    /// 返回[Model]
    ///
    /// - Parameter type: model类型
    /// - Returns: [T]
    /// - Throws:
    public func mapArray<T:HandyJSON>(_ type:T.Type) throws -> [T]{
        
        guard let json = try mapJSON() as? [String : Any] else {
            
            
            throw RxSwiftMoyaError.ParseJSONError
        }
        guard let msgCode = json["msgCode"] as? Int else {
            throw RxSwiftMoyaError.ParseJSONError
        }
        var models:[T] = []
        switch msgCode{
        case 1:
            if let data = json["data"] as? [[String:Any]]{
                for dic in data{
                    let model = T.deserialize(from: dic)
                    models.append(model!)
                }
            }
            return models
        default:
            throw RxSwiftMoyaError.OtherError
        }
    }
    
    public func mapData() throws -> [String:Any]{
        
        guard let json = try mapJSON() as? [String : Any] else {
            
            
            throw RxSwiftMoyaError.ParseJSONError
        }
        guard let msgCode = json["msgCode"] as? Int else {
            throw RxSwiftMoyaError.ParseJSONError
        }

        switch msgCode{
        case 1:
            if let data = json["data"] as? [String:Any]{
                return data
            }else{
                throw RxSwiftMoyaError.DataNoDic
            }

        default:
            throw RxSwiftMoyaError.OtherError
        }
    }
    
}



extension ObservableType where E == Response{
    /// 转Model
    ///
    /// - Parameter type:
    /// - Returns:
    public func mapObejct<T:HandyJSON>(_ type:T.Type) -> Observable<T>{
        return flatMap({ (response) -> Observable<T> in
            return Observable.just(try response.mapObject(T.self))
        })
    }
    
    
    /// [Model]
    ///
    /// - Parameter type: <#type description#>
    /// - Returns: <#return value description#>
    public func mapArray<T:HandyJSON>(_ type:T.Type) -> Observable<[T]>{
        return flatMap { response -> Observable<[T]> in
            return Observable.just(try response.mapArray(T.self))
        }
    }
    
    
    /// {"data":返回内容}
    ///
    /// - Returns: <#return value description#>
    public func mapData() -> Observable<[String:Any]>{
        return flatMap { response -> Observable<[String:Any]> in
            return Observable.just(try response.mapData())
        }
    }
    
    public func mapSuccess() -> Observable<Bool>{
        return flatMap { response -> Observable<Bool> in
            return Observable.just(try response.mapSuccess())
        }
    }
}

enum RxSwiftMoyaError: String {
    case RequestError //code=1
    case RequestNoData //数据为空
    case ParseJSONError //json格式错误
    case OtherError //其他错误
    case DataNoObjectModel
    case DataNoArrayModel
    case DataNoDic
}

extension RxSwiftMoyaError: Swift.Error { }

