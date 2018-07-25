//
//  RegisterViewModel.swift
//  SwiftFrame
//
//  Created by mac on 2018/6/21.
//  Copyright © 2018年 thc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya
class RegisterViewModel: NSObject {

    //用户名验证结果
    let validatedUsername: Driver<ValidationResult>
    
    //密码验证结果
    let validatedPassword: Driver<ValidationResult>
    
    //再次输入密码验证结果
    let validatedPasswordRepeated: Driver<ValidationResult>
    
    //注册按钮是否可用
    let signupEnabled: Driver<Bool>
    
    //注册结果
    let signupResult: Driver<Bool>
    
    
    //正在注册中,状态
    let isLoginLoding: Driver<Bool>
    
    
    //ViewModel初始化（根据输入实现对应的输出）
    init(
        input: (
        username: Driver<String>,
        password: Driver<String>,
        repeatedPassword: Driver<String>,
        loginTaps: Signal<Void>
        ),
        dependency: (
        networkService: RegisterNetworkService,
        signupService: RegisterService
        )) {
        
        //用户名验证
        validatedUsername = input.username
            .flatMapLatest { username in
                return dependency.signupService.validateUsername(username)
                    .asDriver(onErrorJustReturn: .failed(message: "服务器发生错误!"))
        }
        
        //用户名密码验证
        validatedPassword = input.password
            .map { password in
                return dependency.signupService.validatePassword(password)
        }
        
        //重复输入密码验证
        validatedPasswordRepeated = Driver.combineLatest(
            input.password,
            input.repeatedPassword,
            resultSelector: dependency.signupService.validateRepeatedPassword)
        
        //注册按钮是否可用  合并并去掉重复的数据
        signupEnabled = Driver.combineLatest(
            validatedUsername,
            validatedPassword,
            validatedPasswordRepeated
        ) { username, password, repeatPassword in
            username.isValid && password.isValid && repeatPassword.isValid
            }
            .distinctUntilChanged()
        
        //获取最新的用户名和密码
        let usernameAndPassword = Driver.combineLatest(input.username, input.password) {
            (username: $0, password: $1) }
        
        //用于检测是否正在请求数据
        let activityIndicator = ActivityIndicator()
        self.isLoginLoding = activityIndicator.asDriver()
        
        //注册按钮点击结果
        signupResult = input.loginTaps.withLatestFrom(usernameAndPassword)
            .flatMapLatest { pair in  //也可考虑改用flatMapFirst
                return dependency.networkService.sigup(pair.username,
                                                        password: pair.password)
                    .trackActivity(activityIndicator)//把当前序列放入signing序列当中
                    .asDriver(onErrorJustReturn: false)
        }
        
        
    }
    
}

class RegisterNetworkService {
    //验证用户名是否存在
    func usernameAvailable(_ username:String) -> Observable<Bool> {
        let url = URL(string: "https://github.com/\(username.URLEscaped)")!
        let request = URLRequest(url: url)
        return URLSession.shared.rx.response(request: request).map({ (pair) in
            return pair.response.statusCode == 404
        }).catchErrorJustReturn(false)
    }
    //注册用户
    func sigup(_ username:String,password:String) -> Observable<Bool> {
        let signupResult = arc4random() % 3 == 0
        return Observable.just(signupResult).delay(0.5, scheduler: MainScheduler.instance)
    }
}

extension String{
    //字符串的url地址转义
    var URLEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }
}

//扩展UILabel
extension Reactive where Base: UILabel {
    //让验证结果（ValidationResult类型）可以绑定到label上
    var validationResult: Binder<ValidationResult> {
        return Binder(base) { label, result in
            label.textColor = result.textColor
            label.text = result.description
        }
    }
}
