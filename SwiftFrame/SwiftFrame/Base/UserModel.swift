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
    
    static let shareInstance = UserModel()
    
    var name:BehaviorRelay<String> = BehaviorRelay(value: "")
    var pic:BehaviorRelay<String> = BehaviorRelay(value: "")
    
    
    
    var token:String = ""

    var GradeID:String = ""
    var GradeName:String = ""
    var Year:String = ""

    var StudentID:String = ""
    var Key:String = ""
    
    
    var Role:UserRole = .Student
    
    func saveUserInfo(dic:[String:Any]) {

        self.pic.accept(dic["Picture"] as! String)
        
        self.GradeID = "\(dic["GradeID"] ?? "")"
        self.name.accept(dic["StuName"] as! String)
        
    }

    
}
