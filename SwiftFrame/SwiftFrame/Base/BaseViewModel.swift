//
//  BaseViewModel.swift
//  SwiftFrame
//
//  Created by mac on 2018/6/6.
//  Copyright © 2018年 thc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import HandyJSON

enum RefreshStatus {
    case none
    case beingHeaderRefresh
    case endHeaderRefresh
    case beingFooterRefresh
    case endFooterRefresh
    case noMoreData
    case Loading
    case Success
}

class BaseViewModel: NSObject {


    let dis = DisposeBag()
    var pageIndex:Int = 1

}


