//
//  LoginViewModel.swift
//  SwiftFrame
//
//  Created by mac on 2018/6/27.
//  Copyright © 2018年 thc. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class LoginViewModel: NSObject {

    //用户名验证结果
    let validatedUsername: Driver<ValidationResult>
    
    //密码验证结果
    let validatedPassword: Driver<ValidationResult>
    
    //登陆按钮是否可用
    let LoginEnabled: Driver<Bool>
    
    
    //登陆结果
    let LoginResult: Driver<Bool>
    
    
    //正在登陆中,状态
    let isLoginLoding: Driver<Bool>
    
    init(input:(
        username:Driver<String>,
        password:Driver<String>,
        type:String,
        loginTap:Signal<Void>
        ),
        dependency:(
        networkService: LoginNetWorkService,
        signupService: LoginService
        )) {
        validatedUsername = input.username
            .map{ username in
            return dependency.signupService.validateUsername(username)
        }
        
        validatedPassword = input.password
            .map{ password in
            return dependency.signupService.validatePassword(password)
        }
        
        //用于检测是否正在请求数据
        let activityIndicator = ActivityIndicator()
        self.isLoginLoding = activityIndicator.asDriver()
        
        //获取最新的用户名和密码
        let usernameAndPassword = Driver.combineLatest(input.username, input.password) {
            (username: $0, password: $1) }
        
        //点击取出用户名跟密码进行登录
        LoginResult =  input.loginTap.withLatestFrom(usernameAndPassword)
            .flatMapLatest{ pair in
                
                return dependency.networkService.Login(pair.username, password: pair.password, type: input.type)
                    .trackActivity(activityIndicator)
                    .asDriver(onErrorJustReturn: false)
        }
        
        LoginEnabled = Driver.combineLatest(validatedPassword,validatedUsername){
            username,password in
            username.isValid && password.isValid
        }.distinctUntilChanged()//去掉重复的
        
    }
}
