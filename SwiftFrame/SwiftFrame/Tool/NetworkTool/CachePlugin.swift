//
//  CachePlugin.swift
//  SwiftFrame
//
//  Created by msxf on 2018/9/18.
//  Copyright © 2018年 thc. All rights reserved.
//

import UIKit
import Moya

let NetCacheKey = "NetCacheKey"
let UserInfoCacheKey = "UserInfoCacheKey"

///缓存协议
protocol CacheTarget : TargetType {
    
    var needsCache: Bool { get }
}

///不是Moya的插件功能,是自己写的
class CachePlugin: NSObject {
    
    static var cache: YYCache? {
        get{
            let cache = YYCache(name: NetCacheKey)
            cache?.diskCache.countLimit = 500
            cache?.memoryCache.countLimit = 50
            return cache
        }
    }

    
    
    /// 存值
    ///
    /// - Parameters:
    ///   - key: <#key description#>
    ///   - value: <#value description#>
    class func saveCacheData(key:String,value:Any)  {
        
        guard let cache = cache else {
            CLog("cache启动失败")
            return
        }
        guard value is NSCoding else {
            CLog("缓存数据不支持NSCoding协议")
            return
        }
        //存值
        cache.setObject(value as? NSCoding, forKey: key)
    }
    
    /// 取值
    ///
    /// - Parameters:
    ///   - key: <#key description#>
    ///   - success: <#success description#>
    ///   - fail: <#fail description#>
    class func getCacheData(key:String,success:@escaping ((Any) -> Void)) {
        guard let cache = cache else {
            CLog("cache启动失败")
            return
        }
        cache.object(forKey: key) { (key, value) in
            success(value)
        }
        
    }
    
    
    /// 查看是否存在缓存
    ///
    /// - Parameters:
    ///   - key: <#key description#>
    ///   - success: <#success description#>
    class func isCache(key:String,success:@escaping ((Bool)->Void)){
        guard let cache = cache else {
            CLog("cache启动失败")
            return
        }
        cache.containsObject(forKey: key) { (key, iscache) in
            success(iscache)
        }
    }
    
}
