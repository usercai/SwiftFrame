//
//  HCRefresh.swift
//  SwiftFrame
//
//  Created by mac on 2018/7/12.
//  Copyright © 2018年 thc. All rights reserved.
//

import UIKit


class HCRefresh: NSObject {

    typealias RefreshBlock = ()->()
    typealias footRefresh = ()->()
    
    class func headerRefresh(refresh:@escaping RefreshBlock) -> MJRefreshGifHeader{
        let header = MJRefreshGifHeader.init {
            refresh()
        }
        
        //        header?.lastUpdatedTimeLabel.isHidden = true
        //        header?.stateLabel.isHidden = true
        return header!
    }
    
    
    class func footerRefresh(refresh:@escaping footRefresh)-> MJRefreshBackGifFooter {
        
        let foot = MJRefreshBackGifFooter.init {
            refresh()
        }
        return foot!
        
    }
}
