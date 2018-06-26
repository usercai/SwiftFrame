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

extension Observable{
    
    /// 转换成DataModel
    /// DataModel为固定的数据结构,需要我们跟后台进行统一
    /// - Parameter type:
    /// - Returns:
    func mapDataModel() -> Observable<DataModel> {
        return self.map { response in
            //if response is a dictionary, then use ObjectMapper to map the dictionary
            //if not throw an error
            
            guard let dict = response as? [String: Any] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            
            return DataModel.deserialize(from: dict)!
        }
    }
    
    
    /// 转换成model
    ///
    /// - Parameter type:
    /// - Returns:
    func mapObject<T: HandyJSON>(type: T.Type) -> Observable<T> {
        return self.map { response in
            //if response is a dictionary, then use ObjectMapper to map the dictionary
            //if not throw an error
            
            guard let dict = response as? [String: Any] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            
            return T.deserialize(from: dict)!
        }
    }
    
    /// 转换成[Model]
    ///
    /// - Parameter type:
    /// - Returns:
    func mapArray<T: HandyJSON>(type: T.Type) -> Observable<[T]> {
        return self.map { response in
            //if response is an array of dictionaries, then use ObjectMapper to map the dictionary
            //if not, throw an error
            guard let array = response as? [Any] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            
            guard let dicts = array as? [[String: Any]] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            var models:[T] = []
            
            for dic in dicts{
                let model = T.deserialize(from: dic)
                models.append(model!)
            }
            return models
        }
    }
    
    
}

enum RxSwiftMoyaError: String {
    case RequestError //code=1
    case RequestNoData //数据为空
    case ParseJSONError //json格式错误
    case OtherError //其他错误
    
}

extension RxSwiftMoyaError: Swift.Error { }

