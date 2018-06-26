//
//  PerSon.swift
//  SwiftFrame
//
//  Created by mac on 2018/6/20.
//  Copyright © 2018年 thc. All rights reserved.
//

import UIKit
import RxSwift

class PerSon: NSObject {
    var name:String = ""
    var age:String = ""
    let username = Variable("username")
    
    lazy var Person = {
        return self.username.asObservable().map{$0 == "hangge" ? "您是管理员" : "您是普通仿员"}.share()
    }()
}
