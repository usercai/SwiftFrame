//
//  LoginService.swift
//  SwiftFrame
//
//  Created by mac on 2018/6/27.
//  Copyright © 2018年 thc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class LoginService: NSObject {


}

class LoginNetWorkService: NSObject {
    
    class func Login(_ username:String ,password:String,type:String) -> Observable<Bool> {
        return homePageTool.rx
            .request(HomePageApi.UserLogin(username, password, type))
            .asObservable().mapSuccess()
            .catchErrorJustReturn(false)
    }
    
    
    
}
