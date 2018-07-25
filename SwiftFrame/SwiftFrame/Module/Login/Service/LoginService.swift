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

    let minPasswordCount = 5
    
    
    //验证用户名
    func validateUsername(_ username: String) -> ValidationResult {
        //判断用户名是否为空
        if username.isEmpty {
            return .empty
        }
        
        //判断用户名是否只有数字和字母
        if username.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) != nil {
            return .failed(message: "用户名只能包含数字和字母")
        }
        
        
        return .ok(message: "")
    }
    
    //验证密码
    func validatePassword(_ password: String) -> ValidationResult {
        let numberOfCharacters = password.count
        
        //判断密码是否为空
        if numberOfCharacters == 0 {
            return .empty
        }
        
        //判断密码位数
        if numberOfCharacters < minPasswordCount {
            return .failed(message: "密码至少需要 \(minPasswordCount) 个字符")
        }
        
        //返回验证成功的结果
        return .ok(message: "密码有效")
    }
    
}

class LoginNetWorkService: NSObject {
    
    func Login(_ username:String ,password:String,type:String) -> Observable<Bool> {
        return homePageTool.rx
            .request(HomePageApi.UserLogin(username, password, type))
            .asObservable().mapData().map({ (data) -> Bool in
                KeyChainTool.saveUserAccount(userAccount: username, Password: password, UserType: type == "0" ? .Student : .Teacher, LoginType: "")
                kUserInfo.saveUserInfo(dic: data["user"] as! [String : Any])
                kUserInfo.Key = data["Key"] as! String
                return true
            })
            .catchErrorJustReturn(false)
            
    }
    
    
    
}
