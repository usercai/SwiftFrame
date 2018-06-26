//
//  UserModel.swift
//  SwiftFrame
//
//  Created by mac on 2018/6/8.
//  Copyright © 2018年 thc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class UserModel: NSObject {

    var name:BehaviorRelay<String> = BehaviorRelay(value: "")
    var token:BehaviorRelay<String> = BehaviorRelay(value: "")

    

    class func isLogin() {
        
    }
}
