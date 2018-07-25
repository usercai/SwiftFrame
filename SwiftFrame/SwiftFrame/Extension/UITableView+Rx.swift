//
//  UITableView+Rx.swift
//  SwiftFrame
//
//  Created by mac on 2018/7/10.
//  Copyright © 2018年 thc. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base : UITableView{
    
    var refreshing: Binder<RefreshStatus>{
        return Binder(base) { table, refresh in
            switch refresh {
            case .beingHeaderRefresh:
                table.mj_header.beginRefreshing()
            case .endHeaderRefresh:
                table.mj_header.endRefreshing()
            case .beingFooterRefresh:
                table.mj_footer.beginRefreshing()
            case .endFooterRefresh:
                table.mj_footer.endRefreshing()
            case .noMoreData:
                table.mj_footer.endRefreshingWithNoMoreData()
            default:
                break
            }
        }
    }
    
    
}
