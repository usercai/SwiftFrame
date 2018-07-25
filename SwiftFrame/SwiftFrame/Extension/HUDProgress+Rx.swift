
//
//  HUDProgress+Rx.swift
//  SwiftFrame
//
//  Created by mac on 2018/7/12.
//  Copyright © 2018年 thc. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
extension Reactive where Base: MBProgressHUD{
    var refreshing: Binder<RefreshStatus>{
        return Binder(base) { hud, refresh in
            switch refresh {

            case .endHeaderRefresh:
                hud.isHidden = true

            case .endFooterRefresh:
                hud.isHidden = true

            default:
                break
            }
        }
    }

}
